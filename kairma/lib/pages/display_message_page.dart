import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: Stack(
        children: [
          Column(
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
                            messages.addAll(List.generate(
                                10,
                                (i) =>
                                    MessageDisplay(Message.generateMessage())));
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
                                    !(messages[index].message.upvote ?? false);
                              }
                            }),
                            selectedIcon: SvgPicture.asset(
                              './images/angel.svg',
                              width: 21,
                            ),
                            unselectedIcon: SvgPicture.asset(
                              './images/angel_outline.svg',
                              width: 21,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: CoolIconThing(
                              selected:
                                  !(messages[index].message.upvote ?? true),
                              onPressed: () => setState(() {
                                if (messages[index].message.upvote == false) {
                                  messages[index].message.upvote = null;
                                } else {
                                  messages[index].message.upvote =
                                      !(messages[index].message.upvote ?? true);
                                }
                              }),
                              selectedIcon: SvgPicture.asset(
                                './images/devil.svg',
                                width: 32,
                              ),
                              unselectedIcon: SvgPicture.asset(
                                './images/devil_outline.svg',
                                width: 32,
                              ),
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
                        selectedIcon: const Icon(
                          Icons.star,
                          size: 32,
                        ),
                        unselectedIcon: const Icon(
                          Icons.star_outline,
                          size: 32,
                        ),
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
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                  icon: const Icon(Icons.person)),
            ),
          )
        ],
      ),
    );
  }
}
