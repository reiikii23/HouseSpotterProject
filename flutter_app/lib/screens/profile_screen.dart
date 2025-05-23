import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 24),

            _buildTextField(label: 'Name', hintText: user['name'] ?? 'John Doe'),
            const SizedBox(height: 12),

            _buildTextField(label: 'Username', hintText: user['username'] ?? 'john.doe123'),
            const SizedBox(height: 12),

            _buildTextField(label: 'Email', hintText: user['email'] ?? 'johndoe@gmail.com'),
            const SizedBox(height: 12),

            _buildTextField(label: 'Bio', hintText: user['bio'] ?? '', maxLines: 3),
            const SizedBox(height: 20),

            const Text('Socials:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.facebook, size: 32),
                SizedBox(width: 16),
                Icon(Icons.camera_alt, size: 32),
                SizedBox(width: 16),
                Icon(Icons.language, size: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hintText, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextField(
          enabled: false,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }
}
