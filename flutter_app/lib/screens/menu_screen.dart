import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'security_settings_screen.dart';
import 'notification_screen.dart';
import 'privacy_settings_screen.dart';
import 'payment_method_screen.dart';
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const MenuScreen({super.key, required this.user});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    user = Map<String, dynamic>.from(widget.user);
  }

  Future<void> deleteUserFromDatabase() async {
    final userId = user['id']; // Ensure your user map includes an 'id' field
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/delete_user/$userId'), // Replace with your actual endpoint
    );

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => Home()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete account.')),
      );
    }
  }

  void _showDeleteAccountDialog(BuildContext context) {
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
                  Icon(Icons.warning_amber_rounded, size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    "Are you sure you want to delete your account?\nThis cannot be undone.",
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
                      child: const Text('CANCEL', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        deleteUserFromDatabase();
                      },
                      child: const Text('DELETE', style: TextStyle(color: Colors.red)),
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
                      child: const Text('CANCEL', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => Home()),
                          (route) => false,
                        );
                      },
                      child: const Text('CONFIRM', style: TextStyle(color: Colors.black)),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
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
            items: ['Notification Settings', 'Privacy Settings'],
          ),
          _buildSettingsCard(
            context,
            title: 'Payment',
            items: ['Bank Account / Cards'],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => _showDeleteAccountDialog(context),
                child: const Text(
                  'Delete account',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () => _showLogoutDialog(context),
                child: const Text(
                  'Log-out',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
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
                    onTap: () async {
                      if (item == 'Profile') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProfileScreen(user: user)),
                        );
                      } else if (item == 'Security Settings') {
                        final updatedUser = await Navigator.push<Map<String, dynamic>>(
                          context,
                          MaterialPageRoute(builder: (_) => SecuritySettingsScreen(user: user)),
                        );
                        if (updatedUser != null) {
                          setState(() {
                            user.addAll(updatedUser);
                          });
                        }
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
