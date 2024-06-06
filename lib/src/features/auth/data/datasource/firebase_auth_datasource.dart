// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// abstract class FirebaseAuthDataSource {
//   Future<User?> signInWithGoogle();
//   Future<void> signOut();
// }

// class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
//   final FirebaseAuth firebaseAuth;

//   FirebaseAuthDataSourceImpl(this.firebaseAuth);

//   @override
//   Future<User?> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;

//     if (googleAuth?.idToken != null && googleAuth?.accessToken != null) {
//       final credential = GoogleAuthProvider.credential(
//         idToken: googleAuth!.idToken,
//         accessToken: googleAuth.accessToken,
//       );

//       final userCredential =
//           await firebaseAuth.signInWithCredential(credential);
//       return userCredential.user;
//     }

//     return null;
//   }

//   @override
//   Future<void> signOut() async {
//     await firebaseAuth.signOut();
//     await GoogleSignIn().signOut();
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthDataSource {
  Future<User?> signInWithGoogle();
  Future<void> signOut();
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDataSourceImpl(this.firebaseAuth);

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
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.idToken == null || googleAuth.accessToken == null) {
        // Missing authentication tokens
        return null;
      }

      // Sign in with Firebase using Google credentials
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken!,
      );
      final userCredential = await firebaseAuth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      // Error occurred during sign-in
      print('Error signing in with Google: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // Sign out from Firebase
      await firebaseAuth.signOut();

      // Sign out from Google
      await GoogleSignIn().signOut();
    } catch (e) {
      // Error occurred during sign-out
      print('Error signing out: $e');
    }
  }
}
