import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'authentication_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _newPasswordController = TextEditingController();

    final auth = AuthService();
    final user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Text("Welcome!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),

              const SizedBox(height: 20),

              Text("User email: ${user?.email ?? 'Unknown'}", style: const TextStyle(fontSize: 24)),

              const SizedBox(height: 20),

              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: 'Change Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) return 'Password must be at least 6 characters';
                return null;
                },
              ),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await auth.changePassword(
                        _newPasswordController.text.trim()
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Password changed successfully")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error changing password: $e")),
                      );
                    }
                  }
                },
                child: const Text("Change Password"),
              ),
                
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  await auth.signOut();

                  if (!context.mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AuthenticationScreen(),
                    ),
                  );
                },
                child: const Text("Logout"),
              )
            ],
          ),
        ),
      )
    );
  }
}