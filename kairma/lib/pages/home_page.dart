import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:kairma/components/wide_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static final List<String> strings =
      "hello there my name is Jason and I like cheese and there is probably a lot more about me but I don't really know"
          .split(' ');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                './images/logo_bad.png',
                height: 64,
              ),
              const SizedBox(
                width: 32,
              ),
              const Text(
                'Care-ma',
                textScaleFactor: 3,
              ),
            ],
          ),
          Center(
            child: Scatter(
              fillGaps: true,
              delegate: ArchimedeanSpiralScatterDelegate(
                  ratio: MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height),
              children: [
                for (String s in strings) ScatterItem(s, Random().nextBool()),
              ],
            ),
          ),
          WideButton(
            text: 'Get Inpired',
            onPressed: () => Navigator.pushNamed(context, "/display"),
          ),
        ],
      ),
    );
  }
}

class ScatterItem extends StatelessWidget {
  const ScatterItem(this.string, this.rotated, {Key? key}) : super(key: key);
  final String string;
  final bool rotated;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: rotated ? 1 : 0,
      child: Text(
        string,
        textScaleFactor: Random().nextDouble() + 1,
        style: TextStyle(
          color: Color.fromARGB(
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(155),
            Random().nextInt(255),
          ),
        ),
      ),
    );
  }
}
