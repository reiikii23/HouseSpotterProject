import 'dart:convert';
import 'package:app1/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // 🔹 Add TextEditingControllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  // 🔹 Function to handle signup
  Future<void> _signup() async {
  final userData = {
    'email': emailController.text,
    'password': passwordController.text,
    'full_name': nameController.text,
    'phone': phoneController.text,
    'address': addressController.text,
  };

  print("🟡 Signup sending: $userData");

  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    print("🟢 Status Code: ${response.statusCode}");
    print("🔵 Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(user: jsonDecode(response.body))),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${response.body}')),
      );
    }
  } catch (e) {
    print("🔴 ERROR: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Center(child: Image.asset('assets/logo.png', height: 80)),
            const SizedBox(height: 20),

            _buildTextField('Email', controller: emailController),
            _buildTextField('Password', controller: passwordController, obscureText: true),
            _buildTextField('Full Name', controller: nameController),
            _buildTextField('Phone Number', controller: phoneController),
            _buildTextField('Address', controller: addressController),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _signup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Sign Up'),
            ),

            const SizedBox(height: 12),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => Home()),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Modified _buildTextField to accept controller
  Widget _buildTextField(String label,
      {TextEditingController? controller, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
