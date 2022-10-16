import 'package:flutter/cupertino.dart';

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
          Image.asset(
            message.imageURL ?? '',
            fit: BoxFit.fill,
            scale: 0.1,
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
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
        )
      ],
    );
  }
}
