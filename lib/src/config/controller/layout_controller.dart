import 'package:flutter/material.dart';
import 'package:investment_app/src/features/auth/presenter/screen/onboarding_screen.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 700) {
        return const OnboardingScreen();
      } else {
        return const Placeholder();
      }
    });
  }
}
