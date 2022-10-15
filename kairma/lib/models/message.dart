import 'package:flutter/cupertino.dart';

class Message {
  final String imageURL, text;
  late final TextStyle textStyle;
  late final TextAlign textAlign;

  Message({
    required this.imageURL,
    required this.text,
    double textSize = 16,
    String font = 'Ariel',
    String alignment = 'left',
    int color = 0,
  }) {
    textStyle =
        TextStyle(fontSize: textSize, fontFamily: font, color: Color(color));
    switch (alignment) {
      case 'left':
        textAlign = TextAlign.left;
        break;
      case 'center':
        textAlign = TextAlign.center;
        break;
      case 'right':
        textAlign = TextAlign.right;
        break;
    }
  }
}
