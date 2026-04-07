import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: RegisterPage());
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Application')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Avatar
              Image.asset('images/3d_avatar_21.png', width: 100, height: 100),
              const SizedBox(height: 16),

              CustomTextField(
                label: 'First Name',
                controller: firstNameController,
              ),
              CustomTextField(
                label: 'Last Name',
                controller: lastNameController,
              ),
              const CustomTextField(label: 'Email', suffixText: '@mritm.ac.in'),
              const CustomTextField(
                label: 'Phone Number',
                prefixText: '+91 ',
                keyboardType: TextInputType.phone,
                maxLength: 10,
              ),
              const Divider(indent: 8, endIndent: 8),
              const CustomTextField(label: 'Username'),
              const CustomTextField(label: 'Password', obscureText: true),
              const CustomTextField(
                label: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String fullName =
                      '${firstNameController.text} ${lastNameController.text}'
                          .trim();
                  if (fullName.isEmpty) fullName = 'User';

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Registration Successful"),
                      content: Text("Welcome, $fullName"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== CUSTOM TEXT FIELD ====================
class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? prefixText;
  final String? suffixText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.prefixText,
    this.suffixText,
    this.keyboardType,
    this.maxLength,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixText: prefixText,
          suffixText: suffixText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
