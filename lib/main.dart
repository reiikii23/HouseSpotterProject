import 'package:flutter/material.dart';

void main() {
  List<String> notes = [
    "Ulam mamayang gabi ay adobo",
    "Ulam bukas ay Sinigang",
    "Mamalengke ako bukas"
  ];

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("Note-Taking App"),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Text("This is the body of the app"),
                ...notes.map((note) => (Text(
                      note,
                      style: TextStyle(fontSize: 24),
                    ))),
                Image.asset('assets/images/cat.jpg'),
                Image.network(
                    "https://images.pexels.com/photos/1619690/pexels-photo-1619690.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
              ],
            ),
          ))));
}
