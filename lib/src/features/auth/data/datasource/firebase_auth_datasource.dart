import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthDataSource {
  Future<User?> signInWithGoogle();
  Future<UserCredential> signInWithEmailPassword(String email, String password);
  Future<UserCredential> signUpWithEmailPassword(String email, String password);
  Future<void> signOut();
}

class AuthServices implements FirebaseAuthDataSource {
  // instance of Auth & Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? get currentUser => _auth.currentUser;

  // Sign in
  @override
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      // sign in user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign up
  @override
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password) async {
    try {
      // create user
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = "";
      switch (e.code) {
        case 'weak-password':
          message =
              'The password is too weak. Please choose a stronger password.';
          break;
        case 'email-already-in-use':
          message = 'The email address is already in use.';
          break;
        // Handle other potential error codes
        default:
          message = 'An error occurred during registration. Please try again.';
      }
      throw Exception(message);
    }
  }

  // Sign in with Google
  @override
  Future<User?> signInWithGoogle() async {
    try {
      // Start Google sign-in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled sign-in
        return null;
      }

      // Get authentication tokens
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.idToken == null || googleAuth.accessToken == null) {
        // Missing authentication tokens
        print('Missing Google ID Token or Access Token');
        return null;
      }

      // Sign in with Firebase using Google credentials
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken!,
      );
      final userCredential = await _auth.signInWithCredential(credential);

      // save user info if it doesn't exist
      _firestore.collection("User").doc(userCredential.user!.uid).set(
        {
          "uid": userCredential.user!.uid,
          "email": userCredential.user!.email,
        },
      );

      return userCredential.user;
    } catch (e) {
      // Error occurred during sign-in
      throw Exception(getErrorString(e.toString()));
    }
  }

  // Sign out
  @override
  Future<void> signOut() async {
    try {
      // Sign out from Firebase
      await _auth.signOut();

      // Sign out from Google
      await GoogleSignIn().signOut();
    } catch (e) {
      // Error occurred during sign-out
      throw Exception(getErrorString(e.toString()));
    }
  }

  // errors
  String? getErrorString(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already in use.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
