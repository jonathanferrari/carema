import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kairma/components/custom_text_field.dart';
import 'package:kairma/components/wide_button.dart';

import '../global/app_theme.dart';

/*
id int
email str
name str
password str
joinDate date

deleted
upvotes
downvotes
posts
*/

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstName = TextEditingController(),
      lastName = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController(),
      confirmPassword = TextEditingController();
  late bool showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    './images/logo_bad.png',
                    height: 64,
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  const Text(
                    'Care-ma',
                    textScaleFactor: 3,
                  ),
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              CustomTextField(
                text: 'First Name',
                controller: firstName,
              ),
              CustomTextField(
                text: 'Last Name',
                controller: lastName,
              ),
              CustomTextField(
                text: 'Email',
                controller: email,
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => showPassword = !showPassword);
                      },
                      icon: Icon(showPassword
                          ? Icons.hide_source
                          : Icons.remove_red_eye),
                    ),
                  ),
                  obscureText: showPassword ? false : true,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: confirmPassword,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),
              WideButton(
                text: 'Sign Up',
                onPressed: () {
                  if (password.text != confirmPassword.text) {
                    confirmPassword.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Oop! Passwords don\'t match'),
                      ),
                    );
                  }
                },
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: AppTheme.secondary)),
                    TextSpan(
                        text: 'Sign In',
                        style: const TextStyle(color: AppTheme.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pop(context)),
                    const TextSpan(
                        text: ' instead!',
                        style: TextStyle(color: AppTheme.secondary)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
