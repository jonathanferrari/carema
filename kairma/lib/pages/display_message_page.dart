import 'package:flutter/material.dart';
import 'package:kairma/components/sign_in_snackbar.dart';
import 'package:kairma/components/wide_button.dart';
import 'package:kairma/main.dart';

import '../components/message_display.dart';
import '../models/message.dart';

class DisplayMessagePage extends StatefulWidget {
  final Message? message;
  const DisplayMessagePage({Key? key, this.message}) : super(key: key);

  @override
  State<DisplayMessagePage> createState() => _DisplayMessagePageState();
}

class _DisplayMessagePageState extends State<DisplayMessagePage> {
  late Message message;
  late bool upvote, downvote, favorite;

  @override
  void initState() {
    super.initState();
    message = widget.message ?? Message.generateMessage();
    upvote = false;
    downvote = false;
    favorite = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: MessageDisplay(message),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(upvote ? Icons.bathroom : Icons.bathroom_outlined),
                onPressed: () {
                  if (signedIn) {
                    setState(() {
                      upvote = !upvote;
                      downvote = false;
                    });
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(signInSnackbar(context));
                  }
                },
              ),
              IconButton(
                icon: Icon(downvote
                    ? Icons.heart_broken
                    : Icons.heart_broken_outlined),
                onPressed: () {
                  if (signedIn) {
                    setState(() {
                      downvote = !downvote;
                      upvote = false;
                    });
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(signInSnackbar(context));
                  }
                },
              ),
              IconButton(icon: const Icon(Icons.save_alt), onPressed: () {}),
              IconButton(
                icon: Icon(favorite ? Icons.star : Icons.star_border),
                onPressed: () {
                  if (signedIn) {
                    setState(() => favorite = !favorite);
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(signInSnackbar(context));
                  }
                },
                color: favorite ? Colors.yellow[600] : Colors.black,
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.autorenew),
            onPressed: () =>
                setState(() => message = Message.generateMessage()),
          ),
          WideButton(
            text: 'Create Message',
            onPressed: () async {
              if (signedIn) {
                Navigator.pushNamed(context, '/create').then(
                  (m) {
                    if (m is Message) setState(() => message = m);
                  },
                );
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(signInSnackbar(context));
              }
            },
          ),
        ],
      ),
    );
  }
}
