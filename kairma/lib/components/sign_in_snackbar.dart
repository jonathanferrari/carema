import 'package:flutter/material.dart';

class SignInSnackbar extends StatelessWidget {
  const SignInSnackbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: const Text('You need an account for this feature'),
      action: SnackBarAction(
        label: 'Sign In',
        onPressed: () {
          Navigator.pushNamed(context, '/signin');
        },
      ),
    );
  }
}
