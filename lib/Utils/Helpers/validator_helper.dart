class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty.";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty.";
    }
    if (value.length <= 8) {
      return "Password must be atleast 8 character.";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value) {
    if (value != validatePassword(value)) {
      return "Password do not match.";
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty.";
    }
    if (value.length < 5) {
      return "Username must be at least 5 characters.";
    }
    return null;
  }

  static String? firstName(String? value) {
    if (value == null || value.isEmpty) {
      return "First Name Can't be empty";
    }
    if (value.length < 3) {
      return "First name should be greater then 3 characters.";
    }
    return null;
  }

  static String? lastName(String? value) {
    if (value == null || value.isEmpty) {
      return "Last Name Can't be empty";
    }
    if (value.length < 3) {
      return "Last name should be greater then 3 characters.";
    }
    return null;
  }
}
