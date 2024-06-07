import 'package:flutter/material.dart';
import 'package:investment_app/src/features/auth/data/datasource/firebase_auth_datasource.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthServices _auth = AuthServices();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _auth.signOut();
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
