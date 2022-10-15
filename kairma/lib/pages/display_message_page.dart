import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:mdi/mdi.dart';

import '../models/message.dart';

class DisplayMessagePage extends StatefulWidget {
  const DisplayMessagePage({Key? key}) : super(key: key);

  @override
  State<DisplayMessagePage> createState() => _DisplayMessagePageState();
}

class _DisplayMessagePageState extends State<DisplayMessagePage> {
  late Message message;
  late bool upvote, downvote, favorite;

  @override
  void initState() {
    super.initState();
    message = Message(text: 'Hello World!', imageURL: './images/image.png');
    upvote = false;
    downvote = false;
    favorite = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                message.imageURL,
              ),
              Center(
                  child: Text(
                message.text,
                style: message.textStyle,
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(upvote ? Mdi.heart : Mdi.heartOutline),
                onPressed: () => setState(() {
                  upvote = !upvote;
                  downvote = false;
                }),
              ),
              IconButton(
                icon: Icon(downvote
                    ? Icons.heart_broken
                    : Icons.heart_broken_outlined),
                onPressed: () => setState(() {
                  downvote = !downvote;
                  upvote = false;
                }),
              ),
              IconButton(
                  icon: const Icon(Icons.save_alt),
                  onPressed: () => ImageDownloader.downloadImage(
                      'https://i.insider.com/602ee9ced3ad27001837f2ac?width=750&format=jpeg&auto=webp')),
              IconButton(
                  icon: Icon(favorite ? Icons.star : Icons.star_border),
                  onPressed: () => setState(() => favorite = !favorite)),
            ],
          ),
          IconButton(icon: const Icon(Icons.heart_broken), onPressed: () {}),
          TextButton(
            child: const Text('Create Message'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
