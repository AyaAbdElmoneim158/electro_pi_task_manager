import 'package:electro_pi_task/core/utils/app_regex.dart';

abstract class FormValidators {
  static String? customTextFormFieldValidator(String? value) {
    if (isValueEmpty(value)) return 'This field is required';
    return null;
  }

  static String? emailValidator(String? value) {
    if (isValueEmpty(value)) return 'This field is required';
    if (!AppRegex.isValidEmail(value!)) return 'Invalid email address';
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters long';
    if (!AppRegex.hasLowerCase(value)) return 'Password must contain at least one lowercase letter';
    if (!AppRegex.hasUpperCase(value)) return 'Password must contain at least one uppercase letter';
    if (!AppRegex.hasNumber(value)) return 'Password must contain at least one number';
    if (!AppRegex.hasSpecialCharacter(value)) return 'Password must contain at least one special character';
    return null;
  }

  static String? binCodeTextFormFieldValidator(String? value) {
    if (isValueEmpty(value) || value!.length < 4) return 'Please enter the correct code';
    return null;
  }

  static String? validateName(String? value) {
    if (isValueEmpty(value)) return 'Please enter your name';
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (isValueEmpty(value)) return 'Please enter your phone number';
    if (!AppRegex.isPhoneNumberValid(value!)) return 'Please enter a valid phone number';
    return null;
  }

  static String? validateAddress(String? value) {
    if (isValueEmpty(value)) return 'Please enter your address';
    return null;
  }

  static bool isValueEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return true;
    return false;
  }
}

