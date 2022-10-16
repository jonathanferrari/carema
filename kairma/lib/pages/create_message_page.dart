import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:kairma/pages/display_message_page.dart';
import 'package:o_color_picker/o_color_picker.dart';

import '../models/message.dart';
import '../components/message_display.dart';

class CreateMessagePage extends StatefulWidget {
  const CreateMessagePage({Key? key}) : super(key: key);

  @override
  State<CreateMessagePage> createState() => _CreateMessagePageState();
}

class _CreateMessagePageState extends State<CreateMessagePage> {
  late Message message;
  late int imageIndex, alignmentIndex;

  @override
  void initState() {
    super.initState();

    imageIndex = Random().nextInt(Message.images.length);
    message = Message();
    alignmentIndex = 4;
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.0,
                    enlargeCenterPage: true,
                    onPageChanged: (i, r) => imageIndex = i,
                    initialPage: imageIndex,
                  ),
                  items: List.generate(
                      Message.images.length,
                      (i) => Image.asset(
                            './images/${Message.images[i]}',
                          )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.099,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.802,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.099,
                      ),
                      child: MessageDisplay(message),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0),
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              color: Colors.grey[300],
            ),
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              scrollPadding: const EdgeInsets.all(8),
              decoration: const InputDecoration.collapsed(
                hintText: 'Your Text Here',
              ),
              onChanged: (s) => setState(() => message.text = s),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 32.0),
            child: Text('Text Size'),
          ),
          Slider(
            value: message.scaleFactor,
            onChanged: (v) => setState(() => message.scaleFactor = v),
            min: 0.5,
            max: 4.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Font Family'),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FontPicker(
                        initialFontFamily: "Berlin Sans",
                        onFontChanged: (PickerFont font) => setState(
                            () => message.textStyle = font.toTextStyle()),
                      ),
                    ),
                  );
                },
                child: Text(message.textStyle.fontFamily.toString()),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Text Color'),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (var states) =>
                      message.textStyle.color ?? const Color(0xFF000000),
                )),
                child: Container(),
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OColorPicker(
                          selectedColor: message.textStyle.color,
                          colors: primaryColorsPalette,
                          onColorChange: (color) {
                            setState(() {
                              message.textStyle = TextStyle(
                                  fontFamily: message.textStyle.fontFamily,
                                  color: color);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text('Text Positioning'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 4),
              child: Stack(
                children: List.generate(
                  Message.alignments.length,
                  (i) => Align(
                    alignment: Message.alignments[i],
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: OutlinedButton(
                        style: i == alignmentIndex
                            ? OutlinedButton.styleFrom(
                                backgroundColor: Colors.lightBlue[100],
                                side: const BorderSide(
                                    color: Colors.blue, width: 2),
                              )
                            : null,
                        child: Container(),
                        onPressed: () => setState(
                          () {
                            alignmentIndex = i;
                            message.alignment = Message.alignments[i];
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
          TextButton(
              child: const Text('Create The Guy'),
              onPressed: () {
                message.scaleFactor *= 1.2;
                message.imageURL = './images/${Message.images[imageIndex]}';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => DisplayMessagePage(
                              message: message,
                            )));
              }),
        ],
      ),
    );
  }
}
