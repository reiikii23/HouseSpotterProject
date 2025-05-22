import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'security_settings_screen.dart';
import 'notification_screen.dart';
import 'privacy_settings_screen.dart';
import 'payment_method_screen.dart'; // <-- Add this import

class MenuScreen extends StatelessWidget {
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.warning_amber_rounded, size: 48),
                  SizedBox(height: 16),
                  Text(
                    "Are you sure you want to log-out?",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => Home()),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'CONFIRM',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search settings',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildSettingsCard(
            context,
            title: 'Account Management',
            items: ['Profile', 'Security Settings'],
          ),
          _buildSettingsCard(
            context,
            title: 'App Settings',
            items: ['Notification Settings', 'Privacy Settings'], // "Language" removed
          ),
          _buildSettingsCard(
            context,
            title: 'Payment',
            items: ['Bank Account / Cards'],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _showLogoutDialog(context),
              child: const Text(
                'Log-out',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required String title, required List<String> items}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (item == 'Profile') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfileScreen()),
                        );
                      } else if (item == 'Security Settings') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SecuritySettingsScreen()),
                        );
                      } else if (item == 'Notification Settings') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const NotificationSettingsScreen()),
                        );
                      } else if (item == 'Privacy Settings') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PrivacySettingsScreen()),
                        );
                      } else if (item == 'Bank Account / Cards') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => BankAccountsCardsPage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$item tapped')),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.star_border, size: 20),
                          const SizedBox(width: 10),
                          Text(item),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
