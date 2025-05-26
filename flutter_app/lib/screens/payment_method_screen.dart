import 'package:flutter/material.dart';

class BankAccountsCardsPage extends StatelessWidget {
  const BankAccountsCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Accounts / Cards'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCardSection(
            title: 'E-Wallet',
            items: [
              _buildItem('Gcash', 'assets/images/gcash.png'),
              _buildItem('Paymaya', 'assets/images/maya.png'),
            ],
          ),
          _buildCardSection(
            title: 'Credit / Debit Card',
            items: [
              _buildItem('Mastercard Debit Card', 'assets/images/mastercard.png'),
            ],
            addText: 'Add New Card',
          ),
          _buildCardSection(
            title: 'Bank Account',
            items: [
              _buildItem('Banko de Oro Bank (BDO)', 'assets/images/BDO.png'),
            ],
            addText: 'Add Bank Account',
          ),
        ],
      ),
    );
  }

  Widget _buildCardSection({
    required String title,
    required List<Widget> items,
    String? addText,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...items,
            if (addText != null) ...[
              const Divider(height: 20),
              InkWell(
                onTap: () {
                  
                },
                child: Row(
                  children: [
                    const Icon(Icons.add_circle_outline),
                    const SizedBox(width: 10),
                    Text('Add $addText'),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(imagePath, height: 24, width: 24),
          const SizedBox(width: 12),
          Text(name),
        ],
      ),
    );
  }
}
