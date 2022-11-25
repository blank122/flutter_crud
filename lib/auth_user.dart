import 'package:flutter/material.dart';

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    // ignore: curly_braces_in_flow_control_structures
    return 'Email address is required.';

  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address Format';
  return null;
}

String? validatePassword(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    // ignore: curly_braces_in_flow_control_structures
    return 'Password is required.';
  return null;
}

String? registerPassword(String? value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value == null || value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Enter valid password';
    } else {
      return null;
    }
  }
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
