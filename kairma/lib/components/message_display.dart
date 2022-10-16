import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';

class MessageDisplay extends StatelessWidget {
  final Message message;

  const MessageDisplay(
    this.message, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (message.imageURL != null)
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                message.imageURL ?? '',
              ),
            ),
          ),
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.802,
            width: MediaQuery.of(context).size.width * 0.802,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Message.alignments[message.alignment],
                child: Text(
                  message.text,
                  style: message.textStyle,
                  textScaleFactor: message.scaleFactor,
                  textAlign: Message.textAlignments[message.alignment % 3],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
