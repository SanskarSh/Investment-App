import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:investment_app/src/core/constant/string.dart';
import 'package:investment_app/src/core/service/storage/secure_storage.dart';

abstract class FirebaseAuthDataSource {
  Future<User?> signInWithGoogle();
  Future<UserCredential> signInWithEmailPassword(String email, String password);
  Future<void> signOut();
}

class AuthServices implements FirebaseAuthDataSource {
  // Instance of Auth & Secure Storage
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SecureStorage _secureStorage = SecureStorage();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign in with Email and Password
  @override
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final idTokenResult = await user.getIdTokenResult();
        final accessToken = idTokenResult.token;

        final response = await http.post(
          Uri.parse("${Config.baseUrl}/login/"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"authToken": accessToken}),
        );

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          var token = body['data']['token'];
          await _secureStorage.writeSecureData("jwt_token", token);
        } else {
          throw Exception("Failed to send post request");
        }
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(getErrorString(e.code));
    }
  }

  // Sign in with Google
  @override
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.idToken == null || googleAuth.accessToken == null) {
        log('Missing Google ID Token or Access Token');
        return null;
      }

      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken!, accessToken: googleAuth.accessToken!);
      final userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        final idTokenResult = await user.getIdTokenResult();
        final accessToken = idTokenResult.token;

        final response = await http.post(
          Uri.parse("${Config.baseUrl}/login/"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"authToken": accessToken}),
        );

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          var token = body['data']['token'];
          await _secureStorage.writeSecureData("jwt_token", token);
        } else {
          throw Exception("Failed to send post request");
        }
      }
      return userCredential.user;
    } catch (e) {
      throw Exception(getErrorString(e.toString()));
    }
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  // Sign out
  @override
  Future<void> signOut() async {
    try {
      await _secureStorage.deleteSecureData("jwt_token");
      await _auth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      throw Exception(getErrorString(e.toString()));
    }
  }

  // Error handling
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



  // Sign up
  // @override
  // Future<UserCredential> signUpWithEmailPassword(
  //     String email, String password) async {
  //   try {
  //     // create user
  //     final UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     String message = "";
  //     switch (e.code) {
  //       case 'weak-password':
  //         message =
  //             'The password is too weak. Please choose a stronger password.';
  //         break;
  //       case 'email-already-in-use':
  //         message = 'The email address is already in use.';
  //         break;
  //       // Handle other potential error codes
  //       default:
  //         message = 'An error occurred during registration. Please try again.';
  //     }
  //     throw Exception(message);
  //   }
  // }