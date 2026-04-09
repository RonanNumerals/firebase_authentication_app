import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'authentication_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome!"),

            const SizedBox(height: 20),

            Text("User email: ${user?.email ?? 'Unknown'}"),

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
    );
  }
}