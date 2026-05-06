class Validator {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailVal = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

    if (!emailVal.hasMatch(value)) {
      return 'Enter a valid Emai address.';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Add an Uppercase letter.';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 Characters.';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Add a lower case.';
    }

    if (!RegExp(r'[0-1]').hasMatch(value)) {
      return 'Add a number.';
    }

    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'Add a special character';
    }
    return null;
  }
}
