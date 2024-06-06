// import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:investment_app/src/config/routes/app_route_const.dart';
import 'package:investment_app/src/features/auth/presenter/screen/onboarding_screen.dart';
import 'package:investment_app/src/features/home/presenter/screen/home_screen.dart';
import 'package:investment_app/src/features/splash/presenter/screen/splash_screen.dart';

class AppRoute {
  late final GoRouter router;

  AppRoute() {
    router = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          name: RouteNames.splash,
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          name: RouteNames.onboarding,
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          name: RouteNames.home,
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
      redirect: (context, state) async {
        // final User? user = FirebaseAuth.instance.currentUser;

        final bool isSplash = state.matchedLocation == '/splash';
        final bool isOnboarding = state.matchedLocation == '/onboarding';
        // final bool isHome = state.matchedLocation == '/home';

        if (isSplash) {
          return null;
          // } else if (user != null && !isHome) {
          // return '/home';
        } else if (!isOnboarding) {
          return '/onboarding';
        }
        return null;
      },
    );
  }
}
