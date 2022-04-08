String? validateUsername(String name) {
  String namePattern = r"^[a-z ]+$";
  RegExp regex = new RegExp(
    namePattern,
    caseSensitive: false,
  );

  if (!regex.hasMatch(name)) {
    return 'Invalid name format';
  }
  return null;
}

String? validatePhone(String phone) {
  String phonePattern = r"((\+)?977)?(98)[0-9]{8}$"; //regex for validating Nepali Mobile Number
  RegExp regex = new RegExp(phonePattern);

  if (!regex.hasMatch(phone)) {
    return 'Invalid phone number';
  }
  return null;
}

String? validateEmail(String email) {
  String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+( )?$"; //regex for validating the email
  RegExp regex = new RegExp(
    emailPattern,
    multiLine: true,
  );

  if (!regex.hasMatch(email)) {
    return 'Invalid email address';
  }
  return null;
}

String? validatePassword(String password) {
  if (password.length < 8) {
    return 'Atleast 8 characters';
  }
  return null;
}

String? validateConfirmPassword(String password, String confirmPassword) {
  if (password != confirmPassword) {
    return 'Passwords didn\'t match';
  }
  return null;
}
