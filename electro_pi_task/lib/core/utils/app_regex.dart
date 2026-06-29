class AppRegex {
  static bool isValidEmail(String email) => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  static bool isPasswordValid(String password) => RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$").hasMatch(password);
  static bool hasNumberOrSpecialCharacter(String password) => RegExp(r'^(?=.*?[0-9#?!@$%^&*-])').hasMatch(password);
  static bool isPhoneNumberValid(String phoneNumber) => RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phoneNumber);
  static bool hasLowerCase(String password) => RegExp(r'^(?=.*[a-z])').hasMatch(password);
  static bool hasUpperCase(String password) => RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  static bool hasNumber(String password) => RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  static bool hasSpecialCharacter(String password) => RegExp(r'^(?=.*?[#?!@$%^&*_\-])').hasMatch(password);
  static bool hasMinLength(String password) => RegExp(r'^(?=.{8,})').hasMatch(password);
  static bool isNumeric(String text) => RegExp(r'^[0-9]+$').hasMatch(text);
}
