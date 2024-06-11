import 'package:flutter/material.dart';
import 'package:investment_app/src/features/blog_feed/presenter/screen/blog_screen.dart';
import 'package:investment_app/src/features/home/presenter/widget/navigation_button.dart';
import 'package:investment_app/src/features/home/presenter/widget/qr_scanner.dart';
import 'package:ionicons/ionicons.dart';
import 'package:investment_app/src/features/auth/data/datasource/firebase_auth_datasource.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ValueNotifier<bool> homeSelected = ValueNotifier(false);
  final ValueNotifier<bool> blogSelected = ValueNotifier(true);
  final ValueNotifier<bool> profileSelected = ValueNotifier(false);
  final ValueNotifier<bool> logoutSelected = ValueNotifier(false);
  final PageController pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    AuthServices _auth = AuthServices();

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const QRScannerSheet(),
          );
        },
        child: const Icon(Ionicons.qr_code),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Center(
            child: Text("Home"),
          ),
          BlogScreen(),
          Center(
            child: Text("Profile"),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              spreadRadius: 20,
              blurRadius: 60,
              offset: const Offset(0, -1),
            ),
          ],
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavigationButton(
              pageController: pageController,
              tooltip: "Home",
              icon: Ionicons.home_outline,
              selectedIcon: Ionicons.home,
              iconSelected: homeSelected,
              onPressed: () {
                pageController.jumpToPage(0);
                homeSelected.value = true;
                blogSelected.value = false;
                profileSelected.value = false;
                logoutSelected.value = false;
              },
            ),
            NavigationButton(
              pageController: pageController,
              tooltip: "Blog",
              icon: Ionicons.compass_outline,
              selectedIcon: Ionicons.compass,
              iconSelected: blogSelected,
              onPressed: () {
                pageController.jumpToPage(1);
                homeSelected.value = false;
                blogSelected.value = true;
                profileSelected.value = false;
                logoutSelected.value = false;
              },
            ),
            const SizedBox(),
            NavigationButton(
              pageController: pageController,
              tooltip: "Profile",
              icon: Ionicons.person_outline,
              selectedIcon: Ionicons.person,
              iconSelected: profileSelected,
              onPressed: () {
                pageController.jumpToPage(2);
                homeSelected.value = false;
                blogSelected.value = false;
                profileSelected.value = true;
                logoutSelected.value = false;
              },
            ),
            NavigationButton(
              pageController: pageController,
              tooltip: "Logout",
              icon: Ionicons.log_out_outline,
              selectedIcon: Ionicons.log_out,
              iconSelected: logoutSelected,
              onPressed: () {
                _auth.signOut();
                homeSelected.value = false;
                blogSelected.value = false;
                profileSelected.value = false;
                logoutSelected.value = true;
              },
            ),
          ],
        ),
      ),
    );
  }
}
