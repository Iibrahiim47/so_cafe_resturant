class Validation {
  static String? psdValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'At least 6 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'one digit';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'one special character';
    }
    return null;
  }

  static String? emailValidation(String value) {
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validate(String value, String field) {
    if (value.isEmpty) {
      return 'Please fill the $field';
    }

    return null;
  }
}
