import 'dart:math';

import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  int number = 0;

  void updateNumber() {
    setState(() {
      number = Random().nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(onPressed: updateNumber, child: Text("Randomize")),
          Text(number.toString(), style: TextStyle(fontSize: 50)),
        ],
      ),
    );
  }
}
