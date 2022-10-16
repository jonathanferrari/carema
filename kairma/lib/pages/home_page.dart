import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Home Page'),
          TextButton(
            child: const Text('View Message'),
            onPressed: () => Navigator.pushNamed(context, "/display"),
          )
        ],
      ),
    );
  }
}
