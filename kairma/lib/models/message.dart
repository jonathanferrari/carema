import 'dart:math';

import 'package:flutter/cupertino.dart';

class Message {
  String imageURL, text;
  double scaleFactor;
  late TextStyle textStyle;
  late Alignment alignment;

  Message({
    this.imageURL = 'images/img01.jfif',
    this.text = 'Your Text Here',
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

  static Message generateMessage({String? text}) {
    return Message(
        imageURL: './images/${images[rng.nextInt(images.length)]}',
        text: text ?? 'Your Text Here',
        scaleFactor: (rng.nextDouble() + 0.5) * 2,
        alignment: rng.nextInt(alignments.length),
        color: Color.fromARGB(
            255, rng.nextInt(255), rng.nextInt(255), rng.nextInt(255)));
  }
}
