import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';

import '../models/message.dart';
import '../components/message_display.dart';

class CreateMessagePage extends StatefulWidget {
  const CreateMessagePage({Key? key}) : super(key: key);

  @override
  State<CreateMessagePage> createState() => _CreateMessagePageState();
}

class _CreateMessagePageState extends State<CreateMessagePage> {
  late Message message;

  @override
  void initState() {
    super.initState();

    message = Message();
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
              child: MessageDisplay(message),
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
            Slider(
              value: message.scaleFactor,
              onChanged: (v) => setState(() => message.scaleFactor = v),
              min: 0.5,
              max: 4.5,
            ),
            TextButton(
                Widget: const Text('Pick a font'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FontPicker(
                        onFontChanged: (PickerFont font) => setState(
                            () => message.textStyle = font.toTextStyle()),
                      ),
                    ),
                  );
                }),
          ],
        ));
  }
}
