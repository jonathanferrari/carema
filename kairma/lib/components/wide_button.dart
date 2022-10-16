import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const WideButton({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          child: Text(
            text,
            textScaleFactor: 1.6,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
