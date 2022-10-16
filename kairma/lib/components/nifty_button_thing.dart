import 'package:flutter/material.dart';

class NiftyButtonThing extends StatelessWidget {
  final Function() onPressed;
  const NiftyButtonThing({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Container(),
      onPressed: onPressed,
    );
  }
}
