import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:week_5_task_1/auth_user.dart';
import 'package:week_5_task_1/text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  var spacer = const SizedBox(
    height: 20,
  );

  var inputspacer = const SizedBox(
    height: 10,
  );

  var dividers = const Divider(
    thickness: 2,
    color: Colors.black,
  );

  var inputsTextStyle = GoogleFonts.montserrat(
    fontSize: 14,
  );

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    if (_key.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        errorMessage = '';
      } on FirebaseAuthException catch (error) {
        if (error.toString().contains('user-not-found')) {
          errorMessage = 'Invalid Username or Password';
        }
        if (error.toString().contains('wrong-password')) {
          errorMessage = 'Invalid Password';
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: Form(
        key: _key,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/login_image.svg',
                    height: 200,
                  ),
                  spacer,
                  Text(
                    'Welcome Back',
                    style: headerStyle,
                  ),
                  spacer,
                  Text(
                    'Login To Your Account',
                    style: mainArticleStyle,
                  ),
                  spacer,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      validator: validateEmail,
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        hintText: 'Johndoe@example.com',
                        hintStyle: inputsTextStyle,
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  inputspacer,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      validator: validatePassword,
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.black),
                        hintText: '*******',
                        fillColor: Colors.grey[200],
                        hintStyle: inputsTextStyle,
                        filled: true,
                      ),
                    ),
                  ),
                  spacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      dividers,
                      Text(
                        'Or Sign up with',
                        style: mainArticleStyle,
                      ),
                      dividers,
                    ],
                  ),
                  //sign up with google and facebook
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton.icon(
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.pink,
                            ),
                            label: Text(
                              'Google',
                              style: iconsTextStyle,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton.icon(
                            icon: const FaIcon(
                              FontAwesomeIcons.facebook,
                              color: Colors.pink,
                            ),
                            label: Text(
                              'Facebook',
                              style: iconsTextStyle,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  //button to sign up
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.blue[400],
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    errorMessage,
                    style: errorTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
