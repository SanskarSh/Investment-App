import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment_app/injection_container.dart';
import 'package:investment_app/src/config/controller/theme_controller.dart';
import 'package:investment_app/src/config/routes/app_route_config.dart';
import 'package:investment_app/src/config/theme/theme.dart';
import 'package:investment_app/src/core/service/connectivity/cubit/internet_cubit.dart';
import 'package:investment_app/src/features/auth/presenter/bloc/auth_bloc.dart';

class MyApp extends StatelessWidget {
  final SettingsController controller;

  MyApp({super.key, required this.controller});

  final AppRoute _appRoute = AppRoute();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => si<InternetCubit>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => si<AuthBloc>(),
        ),
      ],
      child: ListenableBuilder(
        listenable: controller,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            themeMode: controller.themeMode,
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            routerDelegate: _appRoute.router.routerDelegate,
            routeInformationParser: _appRoute.router.routeInformationParser,
            routeInformationProvider: _appRoute.router.routeInformationProvider,
          );
        },
      ),
    );
  }
}
