import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kairma/components/cool_icon_thing.dart';
import 'package:kairma/components/message_display.dart';
import 'package:kairma/components/sign_in_snackbar.dart';
import 'package:kairma/components/wide_button.dart';
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

  @override
  void initState() {
    super.initState();
    messages =
        List.generate(10, (i) => MessageDisplay(Message.generateMessage()));
    index = 0;
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    aspectRatio: 1.0,
                    enlargeCenterPage: true,
                    onPageChanged: (i, r) => setState(() {
                      if (i >= messages.length - 5) {
                        messages.addAll(List.generate(10,
                            (i) => MessageDisplay(Message.generateMessage())));
                      }
                      index = i;
                    }),
                    initialPage: index,
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
                          selected: messages[index].message.upvote ?? false,
                          onPressed: () => setState(() {
                                if (messages[index].message.upvote == true) {
                                  messages[index].message.upvote = null;
                                } else {
                                  messages[index].message.upvote =
                                      !(messages[index].message.upvote ??
                                          false);
                                }
                              }),
                          selectedIcon: Icons.ice_skating,
                          unselectedIcon: Icons.ice_skating_outlined),
                      const SizedBox(
                        width: 16,
                      ),
                      CoolIconThing(
                        selected: !(messages[index].message.upvote ?? true),
                        onPressed: () => setState(() {
                          if (messages[index].message.upvote == false) {
                            messages[index].message.upvote = null;
                          } else {
                            messages[index].message.upvote =
                                !(messages[index].message.upvote ?? true);
                          }
                        }),
                        selectedIcon: Icons.yard,
                        unselectedIcon: Icons.yard_outlined,
                      ),
                    ],
                  ),
                  CoolIconThing(
                    selected: messages[index].message.favorite,
                    onPressed: () => setState(() {
                      messages[index].message.favorite =
                          !messages[index].message.favorite;
                    }),
                    selectedIcon: Icons.star,
                    unselectedIcon: Icons.star_outline,
                    selectionColor: const Color.fromARGB(255, 241, 225, 6),
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
                      setState(() => messages.insert(index, MessageDisplay(m)));
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
    );
  }
}
