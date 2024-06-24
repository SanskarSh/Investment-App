import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/src/features/auth/presenter/screen/onboarding_screen.dart';
import 'package:investment_app/src/features/entry/presenter/screen/entry_screen.dart';
import 'package:investment_app/src/features/register/view/screen/registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> _userHasData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('User').doc(user.uid).get();
      return userDoc.exists;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, authSnapshot) {
                if (authSnapshot.connectionState == ConnectionState.active) {
                  if (authSnapshot.hasData) {
                    return FutureBuilder<bool>(
                      future: _userHasData(),
                      builder: (context, firestoreSnapshot) {
                        if (firestoreSnapshot.connectionState ==
                            ConnectionState.done) {
                          if (firestoreSnapshot.data == true) {
                            return EntryScreen();
                          } else {
                            return const RegistrationScreen();
                          }
                        } else {
                          return buildBody();
                        }
                      },
                    );
                  } else {
                    return const OnboardingScreen();
                  }
                } else {
                  return buildBody();
                }
              },
            );
          } else {
            return buildBody();
          }
        },
      ),
    );
  }

  Center buildBody() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
