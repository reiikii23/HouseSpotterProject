import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<_PrivacyOption> options = [
      _PrivacyOption(
        title: 'Request your personal data',
        subtitle: 'We\'ll create a file for you to download your personal data.',
        onTap: () {
          
        },
      ),
      _PrivacyOption(
        title: 'Delete your Account',
        subtitle: 'This will permanently delete your account and your data, in accordance with applicable law.',
        onTap: () {
          
        },
      ),
      _PrivacyOption(
        title: 'Sharing',
        subtitle: 'Decide how your profile and activity are shown to others.',
        onTap: () {
          
        },
      ),
      _PrivacyOption(
        title: 'Services',
        subtitle: 'View and manage services that you\'ve connected to your account.',
        onTap: () {
          
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: options.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final option = options[index];
          return ListTile(
            title: Text(option.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(option.subtitle),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: option.onTap,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          );
        },
      ),
    );
  }
}

class _PrivacyOption {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  _PrivacyOption({required this.title, required this.subtitle, required this.onTap});
}
