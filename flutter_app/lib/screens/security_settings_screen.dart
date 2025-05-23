import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecuritySettingsScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const SecuritySettingsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _SecuritySettingsScreenState createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController emergencyController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  final Map<String, bool> editable = {
    "name": false,
    "phone": false,
    "password": false,
    "emergency": false,
    "email": false,
    "address": false,
  };

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user['full_name'] ?? '');
    phoneController = TextEditingController(text: widget.user['phone'] ?? '');
    passwordController = TextEditingController(text: "********");
    emergencyController = TextEditingController(text: widget.user['emergency'] ?? '');
    emailController = TextEditingController(text: widget.user['email'] ?? '');
    addressController = TextEditingController(text: widget.user['address'] ?? '');
  }

  Future<void> saveChanges() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/users/${widget.user["id"]}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'full_name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update: ${response.reasonPhrase}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final updatedUser = {
              'full_name': nameController.text,
              'phone': phoneController.text,
              'emergency': emergencyController.text,
              'email': emailController.text,
              'address': addressController.text,
            };
            Navigator.pop(context, updatedUser);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildEditableRow("Name", nameController, "name"),
          _buildEditableRow("Phone Number", phoneController, "phone", hint: "Not Provided"),
          _buildEditableRow("Password", passwordController, "password", obscure: true),
          _buildEditableRow("Emergency Contact", emergencyController, "emergency", hint: "Not Provided"),
          _buildEditableRow("Email", emailController, "email"),
          _buildEditableRow("Address", addressController, "address", hint: "Not Provided"),
        ],
      ),
    );
  }

  Widget _buildEditableRow(String label, TextEditingController controller, String key,
      {String? hint, bool obscure = false}) {
    final isEditing = editable[key] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  editable[key] = !(editable[key] ?? false);
                  if (!editable[key]!) {
                    saveChanges(); // Call backend update when user clicks "Done"
                  }
                });
              },
              child: Text(
                key == "password" ? (isEditing ? "Done" : "Change") : (isEditing ? "Done" : "Edit"),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            )
          ],
        ),
        const SizedBox(height: 4),
        isEditing
            ? TextField(
                controller: controller,
                obscureText: obscure,
                decoration: const InputDecoration(
                  isDense: true,
                  border: UnderlineInputBorder(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  controller.text.isNotEmpty ? controller.text : (hint ?? ""),
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
        const Divider(thickness: 1, height: 24),
      ],
    );
  }
}
