import 'package:dio/dio.dart';
import 'package:electro_pi_task/core/error/error_model.dart';
import 'package:electro_pi_task/core/error/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServerException implements Failure {
  final ErrorModel errModel;
  ServerException({required this.errModel});

  @override
  ErrorModel get errorModel => errModel;
}

void handleDioExceptions(DioException e) {
  debugPrint('🌐 DioException: ${e.type} | ${e.response?.statusCode} | ${e.response?.data}');

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      throw ServerException(errModel: ErrorModel(message: 'Connection error, check your internet'));
    case DioExceptionType.badCertificate:
      throw ServerException(errModel: ErrorModel(message: 'Bad certificate error'));
    case DioExceptionType.cancel:
      throw ServerException(errModel: ErrorModel(message: 'Request cancelled'));
    case DioExceptionType.badResponse:
      _handleBadResponse(e);
      break;
    case DioExceptionType.unknown:
      throw ServerException(errModel: ErrorModel(message: 'Unexpected error occurred'));
  }
}

/// Helper to handle 4xx and 5xx status codes
void _handleBadResponse(DioException e) {
  final response = e.response;
  final statusCode = response?.statusCode;
  final data = response?.data;

  if (data != null && data is Map<String, dynamic>) {
    throw ServerException(errModel: ErrorModel.fromJson(data));
  } else {
    throw ServerException(errModel: ErrorModel(message: 'Server error: ${statusCode ?? "Unknown status"}'));
  }
}

void handleFirebaseAuthExceptions(FirebaseAuthException e) {
  debugPrint('🔥 FirebaseAuthException: [${e.code}] | ${e.message}');
  String message;

  switch (e.code) {
    case 'user-not-found':
      message = 'No user found with this email.';
      break;
    case 'wrong-password':
      message = 'Incorrect password. Please try again.';
      break;
    case 'email-already-in-use':
      message = 'This email is already registered.';
      break;
    case 'invalid-email':
      message = 'The email address is not valid.';
      break;
    case 'user-disabled':
      message = 'This user account has been disabled.';
      break;
    case 'weak-password':
      message = 'The password provided is too weak.';
      break;
    case 'operation-not-allowed':
      message = 'Enable this auth provider in the Firebase Console.';
      break;
    case 'too-many-requests':
      message = 'Too many attempts. Please try again later.';
      break;
    case 'network-request-failed':
      message = 'Network error. Please check your internet connection.';
      break;
    default:
      message = e.message ?? 'An unexpected authentication error occurred.';
  }

  throw ServerException(
    errModel: ErrorModel(message: message),
  );
}

void handleFirebaseException(FirebaseException e) {
  String message;

  switch (e.code) {
    case 'permission-denied':
      message = 'You do not have permission to access this data.';
      break;
    case 'unavailable':
      message = 'The service is currently unavailable. Check your internet.';
      break;
    case 'not-found':
      message = 'The requested document was not found.';
      break;
    case 'already-exists':
      message = 'The document you are trying to create already exists.';
      break;
    case 'deadline-exceeded':
      message = 'The connection timed out. Please try again.';
      break;
    default:
      message = e.message ?? 'A database error occurred.';
  }

  throw ServerException(errModel: ErrorModel(message: message));
}
