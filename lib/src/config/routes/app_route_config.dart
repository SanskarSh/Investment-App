import 'package:go_router/go_router.dart';
import 'package:investment_app/src/config/routes/app_route_const.dart';
import 'package:investment_app/src/features/entry/presenter/screen/entry_screen.dart';
import 'package:investment_app/src/features/investment/presenter/screen/investment_screen.dart';
import 'package:investment_app/src/features/retirement_goal/preseter/screen/retirement_screen.dart';
import 'package:investment_app/src/features/splash/presenter/screen/splash_screen.dart';
import 'package:investment_app/src/features/user_balance/presenter/screen/user_balance_screen.dart';

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
          name: RouteNames.home,
          path: '/home',
          builder: (context, state) => EntryScreen(),
        ),
        GoRoute(
          name: RouteNames.balance,
          path: '/balance',
          builder: (context, state) => const UserBalanceScreen(),
        ),
        GoRoute(
          name: RouteNames.investment,
          path: '/investment',
          builder: (context, state) => const InvestmentScreen(),
        ),
        GoRoute(
          name: RouteNames.retirement,
          path: '/retirement',
          builder: (context, state) => const RetirementScreen(),
        ),
      ],
    );
  }
}
