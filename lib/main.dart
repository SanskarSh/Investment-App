import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/firebase_options.dart';
import 'package:investment_app/injection_container.dart';
import 'package:investment_app/src/app.dart';
import 'package:investment_app/src/config/controller/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDependencies();
  final settingsController = si<SettingsController>();
  await settingsController.loadSettings();
  runApp(MyApp(controller: settingsController));
}
