import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(23),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 32, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Fruit Basket',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 96),
              ),
            ],
          )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withValues(alpha: .2),
                    width: 1))),
        child: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/plus.png'),
              ),
              label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List')
        ]),
      ),
    );
  }
}
