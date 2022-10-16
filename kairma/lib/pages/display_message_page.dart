import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kairma/components/cool_icon_thing.dart';
import 'package:kairma/components/message_display.dart';
import 'package:kairma/components/sign_in_snackbar.dart';
import 'package:kairma/components/wide_button.dart';
import 'package:kairma/global/app_theme.dart';
import 'package:kairma/main.dart';

import '../models/message.dart';

class DisplayMessagePage extends StatefulWidget {
  const DisplayMessagePage({Key? key}) : super(key: key);

  @override
  State<DisplayMessagePage> createState() => _DisplayMessagePageState();
}

class _DisplayMessagePageState extends State<DisplayMessagePage> {
  late List<MessageDisplay> messages;
  late int index;
  late String category;
  late bool loading;

  @override
  void initState() {
    super.initState();
    messages = [];
    initMessages();
    loading = true;
    index = 0;
    category = 'all';
  }

  void initMessages() async {
    await FirebaseFirestore.instance
        .collection('inspirations')
        .get()
        .then((v) => v.docs.forEach((e) => messages.add(
              MessageDisplay(
                Message(
                  userID: e['userID'],
                  imageURL: e['image'],
                  alignment: e['alignment'],
                  color: Color(e['color']),
                  font: e['font'],
                  scaleFactor: e['scaleFactor'],
                  text: e['text'],
                ),
              ),
            )));
    setState(() {
      loading = false;
    });
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
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              enableInfiniteScroll: true,
                              aspectRatio: 1.0,
                              enlargeCenterPage: true,
                              initialPage: Random().nextInt(messages.length),
                              onPageChanged: (i, r) =>
                                  setState(() => index = i),
                            ),
                            items: messages,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                CoolIconThing(
                                  selected:
                                      !(messages[index].message.upvote ?? true),
                                  onPressed: () => setState(() {
                                    if (messages[index].message.upvote ==
                                        false) {
                                      messages[index].message.upvote = null;
                                    } else {
                                      messages[index].message.upvote =
                                          !(messages[index].message.upvote ??
                                              true);
                                    }
                                  }),
                                  selectedIcon: Image.asset(
                                    './images/devil_red.png',
                                    width: 32,
                                  ),
                                  unselectedIcon: Image.asset(
                                    './images/devil.png',
                                    width: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                CoolIconThing(
                                  selected:
                                      messages[index].message.upvote ?? false,
                                  onPressed: () => setState(() {
                                    if (messages[index].message.upvote ==
                                        true) {
                                      messages[index].message.upvote = null;
                                    } else {
                                      messages[index].message.upvote =
                                          !(messages[index].message.upvote ??
                                              false);
                                    }
                                  }),
                                  selectedIcon: Image.asset(
                                    './images/angel_green.png',
                                    width: 21,
                                  ),
                                  unselectedIcon: Image.asset(
                                    './images/angel.png',
                                    width: 21,
                                  ),
                                ),
                              ],
                            ),
                            CoolIconThing(
                              selected: messages[index].message.favorite,
                              onPressed: () => setState(() {
                                messages[index].message.favorite =
                                    !messages[index].message.favorite;
                              }),
                              selectedIcon: Image.asset(
                                './images/star_yellow.png',
                                width: 28,
                              ),
                              unselectedIcon: Image.asset(
                                './images/star.png',
                                width: 28,
                              ),
                              selectionColor:
                                  const Color.fromARGB(255, 241, 225, 6),
                            ),
                          ],
                        ),
                      ],
                    ),
              WideButton(
                text: 'Create Message',
                onPressed: () async {
                  if (signedIn) {
                    Navigator.pushNamed(context, '/create').then(
                      (m) {
                        if (m is Message) {
                          setState(
                              () => messages.insert(index, MessageDisplay(m)));
                        }
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
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    if (signedIn) {
                      Navigator.pushNamed(context, '/profile');
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(signInSnackbar(context));
                    }
                  },
                  icon: const Icon(Icons.person)),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: category,
                style: const TextStyle(color: Colors.red, fontSize: 30),
                onChanged: (s) => setState(() => category = s ?? category),
                items: const [
                  // TODO: Check Spelling
                  DropdownMenuItem(
                      child: Text(
                        "All",
                        style: TextStyle(color: AppTheme.secondary),
                        textScaleFactor: 0.7,
                      ),
                      value: "all"),
                  DropdownMenuItem(
                      child: Text(
                        "Encouragement",
                        style: TextStyle(color: AppTheme.secondary),
                        textScaleFactor: 0.7,
                      ),
                      value: "encouragement"),
                  DropdownMenuItem(
                      child: Text(
                        "Support",
                        style: TextStyle(color: AppTheme.secondary),
                        textScaleFactor: 0.7,
                      ),
                      value: "support"),
                  DropdownMenuItem(
                      child: Text(
                        "Gratitude",
                        style: TextStyle(color: AppTheme.secondary),
                        textScaleFactor: 0.7,
                      ),
                      value: "gratitude"),
                  DropdownMenuItem(
                      child: Text(
                        "Inspiration",
                        style: TextStyle(color: AppTheme.secondary),
                        textScaleFactor: 0.7,
                      ),
                      value: "inspiration"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
