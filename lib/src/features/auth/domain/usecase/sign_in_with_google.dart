import 'package:firebase_auth/firebase_auth.dart';
import 'package:investment_app/src/features/auth/domain/repository/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<User?> call() async {
    return await repository.signInWithGoogle();
  }
}
