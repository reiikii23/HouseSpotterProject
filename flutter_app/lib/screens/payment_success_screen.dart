import 'package:flutter/material.dart';
import 'home_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.money, size: 80, color: Colors.green),
            SizedBox(height: 10),
            Text("PAYMENT SUCCESSFUL!", style: TextStyle(color: Colors.green, fontSize: 18)),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => HomeScreen(user: {},)), // import HomeScreen
                  (route) => false,
                );
              },

              child: Text("Okay", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            Text("Redirecting to merchant page.", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
