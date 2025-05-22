import 'package:flutter/material.dart';
import 'payment_success_screen.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final String paymentMethod;
  final double totalAmount;

  PaymentConfirmationScreen({required this.paymentMethod, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Confirmation")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("PAYMENT CONFIRMATION", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("No Hidden Charges."),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRow("Date", "04-01-2025"),
                  buildRow("Payment Method", paymentMethod),
                  buildRow("Card Number", "**** **** **** 0000"),
                  buildRow("Cardholder Name", "John Doe"),
                  buildRow("Email", "johndoe@gmail.com"),
                  buildRow("Phone Number", "+63912345678"),
                  buildRow("Total Amount", "₱${totalAmount.toStringAsFixed(0)}"),
                ],
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("CANCEL"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => PaymentSuccessScreen()),
                      );
                    },
                    child: Text("CONFIRM"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          Text(value),
        ],
      ),
    );
  }
}
