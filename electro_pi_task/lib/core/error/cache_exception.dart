import 'package:electro_pi_task/core/error/error_model.dart';
import 'package:electro_pi_task/core/error/failures.dart';

class CacheException implements Failure {
  final String message;
  CacheException(this.message);

  @override
  String toString() => message;

  @override
  ErrorModel get errorModel => throw ErrorModel(message: message);
}

ErrorModel handleCacheException(Object e) {
  late final String errorMessage;

  if (e is CacheException) {
    errorMessage = e.message;
  } else if (e is TypeError) {
    errorMessage = 'Data type mismatch in local storage.';
  } else if (e is String) {
    errorMessage = e;
  } else {
    errorMessage = 'Local Storage Error: ${e.toString()}';
  }
  return ErrorModel(message: errorMessage);
}
