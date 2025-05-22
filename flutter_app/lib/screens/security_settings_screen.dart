import 'package:flutter/material.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({Key? key}) : super(key: key);

  @override
  _SecuritySettingsScreenState createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  final TextEditingController nameController = TextEditingController(text: "FirstName Surname");
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController(text: "********");
  final TextEditingController emergencyController = TextEditingController();
  final TextEditingController emailController = TextEditingController(text: "johndoe@gmail.com");
  final TextEditingController addressController = TextEditingController();

  final Map<String, bool> editable = {
    "name": false,
    "phone": false,
    "password": false,
    "emergency": false,
    "email": false,
    "address": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
