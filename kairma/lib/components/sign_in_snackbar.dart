import 'package:flutter/material.dart';

SnackBar signInSnackbar(BuildContext context) {
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
