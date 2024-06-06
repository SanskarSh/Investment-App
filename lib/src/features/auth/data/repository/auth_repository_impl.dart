import 'package:firebase_auth/firebase_auth.dart';
import 'package:investment_app/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:investment_app/src/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User?> signInWithGoogle() async {
    return await dataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    await dataSource.signOut();
  }
}
