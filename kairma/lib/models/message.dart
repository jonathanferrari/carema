import 'dart:math';

import 'package:flutter/cupertino.dart';

class Message {
  final String imageURL, text;
  final double scaleFactor;
  late final TextStyle textStyle;
  late final Alignment alignment;

  Message({
    required this.imageURL,
    required this.text,
    this.scaleFactor = 2,
    String font = 'Roboto',
    int alignment = 4,
    Color color = const Color(0xFF000000),
  }) {
    textStyle = TextStyle(fontFamily: font, color: color);
    this.alignment = alignments[alignment];
  }

  static const List<Alignment> alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  static Random rng = Random();

  static const List<String> images = [
    'img01.jfif',
    'img02.jfif',
    'img03.jpg',
    'img04.jpg',
    'img05.png',
  ];

  static Message generateMessage() {
    return Message(
        imageURL: './images/${images[rng.nextInt(images.length)]}',
        text:
            'Hello World! I\'m here\n now it\'s great to\n see you all oh yay',
        scaleFactor: (rng.nextDouble() + 0.5) * 2,
        alignment: rng.nextInt(alignments.length),
        color: Color.fromARGB(
            255, rng.nextInt(255), rng.nextInt(255), rng.nextInt(255)));
  }
}
