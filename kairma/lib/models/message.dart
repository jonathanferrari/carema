import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Message {
  String? imageURL;
  String text, userID;
  double scaleFactor;
  late TextStyle textStyle;
  int alignment;
  bool? upvote;
  bool favorite;
  DocumentReference? docRef;

  Message({
    this.imageURL,
    this.text = 'Your Text Here',
    this.scaleFactor = 2,
    String font = 'Lato',
    this.alignment = 4,
    Color color = const Color(0xFF000000),
    this.upvote,
    this.favorite = false,
    required this.userID,
    this.docRef,
  }) {
    textStyle = TextStyle(fontFamily: font, color: color);
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

  static const List<TextAlign> textAlignments = [
    TextAlign.start,
    TextAlign.center,
    TextAlign.end,
  ];

  static Random rng = Random();

  static const List<String> images = [
    'img01.jfif',
    'img02.jfif',
    'img03.jpg',
    'img04.jpg',
    'img05.png',
    'bk2.png',
    'bk3.png',
    'bk4.png',
    'bk5.png',
    'bk6.png',
    'bk7.png',
    'bk8.png',
    'bk9.png',
    'bk10.png',
    'bk11.png',
    'bk12.png',
    'bk13.png',
    'bk14.png',
    'bk15.png',
    'bk16.png',
  ];

  static Message generateMessage({String? text}) {
    // TODO: Add UserID
    return Message(
        imageURL: './images/${images[rng.nextInt(images.length)]}',
        text: text ?? 'Your Text Here',
        scaleFactor: (rng.nextDouble() + 0.5) * 2,
        alignment: rng.nextInt(alignments.length),
        color: Color.fromARGB(
            255, rng.nextInt(255), rng.nextInt(255), rng.nextInt(255)),
        userID: '0');
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      userID: json['userID'],
      imageURL: json['image'],
      alignment: json['alignment'],
      color: Color(json['color']),
      font: json['font'],
      scaleFactor: json['scaleFactor'],
      text: json['text'],
    );
  }
}
