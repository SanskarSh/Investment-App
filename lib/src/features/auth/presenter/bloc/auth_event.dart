part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}
