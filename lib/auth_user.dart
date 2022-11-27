import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    String errMessage = "Some error occured";

    try {
      if (firstName.isNotEmpty ||
          lastName.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(credential.user!.uid);

        await _firestore.collection('users').doc(credential.user!.uid).set({
          'uid': credential.user!.uid,
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password
        });
        errMessage = "Success";
      }
    } catch (err) {}
    return errMessage;
  }
}

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
