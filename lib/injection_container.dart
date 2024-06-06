import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:investment_app/src/core/service/connectivity/cubit/internet_cubit.dart';
import 'package:investment_app/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:investment_app/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:investment_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:investment_app/src/features/auth/domain/usecase/sign_in_with_google.dart';
import 'package:investment_app/src/features/auth/presenter/bloc/auth_bloc.dart';

final si = GetIt.instance;

Future<void> initializeDependencies() async {
  // Register FirebaseAuth and GoogleSignIn
  // si.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  // si.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Data sources
  // si.registerLazySingleton<FirebaseAuthDataSource>(
  // () => FirebaseAuthDataSourceImpl(si()));

  // Repositories
  si.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(si()));

  // Use cases
  si.registerLazySingleton(() => SignInWithGoogle(si()));

  // Register InternetConnection
  si.registerLazySingleton<InternetConnection>(() => InternetConnection());

  // Blocs
  si.registerFactory(() => AuthBloc(si()));
  si.registerFactory(() => InternetCubit(si<InternetConnection>()));
}
