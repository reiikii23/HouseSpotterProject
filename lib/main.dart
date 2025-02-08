import 'package:app1/random.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Randomizer App"),
          ),
          body: Random())));
}
