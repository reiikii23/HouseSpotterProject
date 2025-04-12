import 'package:app1/create_fruits_screen.dart';
import 'package:app1/list_fruits_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // final _screens = [
  //   CreateFruitsScreen(),
  //   ListFruitsScreen(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListFruitsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.plus_one_rounded), label: 'Add Fruit'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List Fruits'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
