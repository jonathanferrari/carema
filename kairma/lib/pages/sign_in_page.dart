import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kairma/components/custom_text_field.dart';
import 'package:kairma/components/wide_button.dart';
import 'package:kairma/global/app_theme.dart';
import 'package:kairma/main.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController email = TextEditingController(),
      password = TextEditingController();
  late bool showPassword, loading;

  @override
  void initState() {
    super.initState();
    showPassword = false;
    loading = false;
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 16,
              ),
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
                text: 'Email',
                controller: email,
              ),
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
              WideButton(
                text: 'Sign In',
                onPressed: () async {
                  if (loading) return;
                  setState(() {
                    loading = true;
                  });
                  await FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: email.text)
                      .where('password', isEqualTo: password.text)
                      .get()
                      .then((v) {
                    if (v.size > 0) {
                      userID = v.docs[0].id;
                      signedIn = true;
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Email/Password incorrect'),
                      ));
                      setState(() {
                        password.clear();
                      });
                    }
                  });
                  setState(() {
                    loading = false;
                  });
                },
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(color: AppTheme.secondary)),
                    TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(color: AppTheme.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Navigator.pushNamed(context, '/signup')),
                    const TextSpan(
                        text: ' today!',
                        style: TextStyle(color: AppTheme.secondary)),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }
}
