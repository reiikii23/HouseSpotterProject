import 'package:flutter/material.dart';
import 'payment_confirmation_screen.dart';

class PaymentMethodScreen extends StatelessWidget {
  final double totalAmount;

  PaymentMethodScreen({required this.totalAmount});

  void navigateToConfirmation(BuildContext context, String method) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentConfirmationScreen(
          paymentMethod: method,
          totalAmount: totalAmount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Payment Method")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("E-Wallet", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: Image.asset('assets/gcash.png', width: 30),
            title: Text("GCash"),
            onTap: () => navigateToConfirmation(context, "GCash"),
          ),
          ListTile(
            leading: Image.asset('assets/paymaya.png', width: 30),
            title: Text("Paymaya"),
            onTap: () => navigateToConfirmation(context, "Paymaya"),
          ),
          Divider(),
          Text("Credit / Debit Card", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: Icon(Icons.credit_card, color: Colors.red),
            title: Text("Mastercard Debit Card"),
            onTap: () => navigateToConfirmation(context, "Mastercard"),
          ),
          Divider(),
          Text("Bank Account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: Image.asset('assets/bdo.png', width: 30),
            title: Text("Banko de Oro (BDO)"),
            onTap: () => navigateToConfirmation(context, "BDO"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.money, color: Colors.green),
            title: Text("Cash on Hand"),
            onTap: () => navigateToConfirmation(context, "Cash on Hand"),
          ),
        ],
      ),
    );
  }
}
