import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:investment_app/src/features/auth/domain/usecase/sign_in_with_google.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogle signInWithGoogle;

  AuthBloc(this.signInWithGoogle) : super(AuthInitial()) {
    on<SignInRequested>((event, emit) async {
      try {
        final user = await signInWithGoogle();
        emit(Authenticated(user!));
      } catch (_) {
        emit(AuthError('Failed to sign in with Google'));
      }
    });

    on<SignOutRequested>((event, emit) async {
      await signInWithGoogle.repository.signOut();
      emit(Unauthenticated());
    });
  }
}
