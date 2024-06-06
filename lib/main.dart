import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:investment_app/firebase_options.dart';
import 'package:investment_app/injection_container.dart';
import 'package:investment_app/src/app.dart';
import 'package:investment_app/src/config/controller/theme_controller.dart';
import 'package:investment_app/src/config/service/theme_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final settingsController = SettingsController(SettingService());
  await settingsController.loadSettings();
  runApp(MyApp(controller: settingsController));
}
