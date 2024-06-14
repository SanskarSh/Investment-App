import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:investment_app/src/features/blog_feed/presenter/screen/blog_screen.dart';
import 'package:investment_app/src/features/entry/presenter/widget/chat_screen.dart';
import 'package:investment_app/src/features/entry/presenter/widget/navigation_button.dart';
import 'package:investment_app/src/features/home/presenter/screen/home_screen.dart';
import 'package:investment_app/src/features/home/presenter/widget/qr_scanner.dart';
import 'package:ionicons/ionicons.dart';
import 'package:investment_app/src/features/auth/data/datasource/firebase_auth_datasource.dart';

class EntryScreen extends StatelessWidget {
  EntryScreen({super.key});

  final ValueNotifier<bool> homeSelected = ValueNotifier(true);
  final ValueNotifier<bool> blogSelected = ValueNotifier(false);
  final ValueNotifier<bool> profileSelected = ValueNotifier(false);
  final ValueNotifier<bool> logoutSelected = ValueNotifier(false);
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    AuthServices _auth = AuthServices();

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const ChatScreen(),
          );
        },
        child: const Center(child: Icon(Ionicons.chatbox_ellipses)),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeScreen(),
          BlogScreen(),
          Center(child: Text("Profile")),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
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
            const SizedBox(),
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
            ValueListenableBuilder(
              valueListenable: homeSelected,
              builder: (_, __, ___) {
                if (homeSelected.value) {
                  return SpeedDial(
                    elevation: 0,
                    animationDuration: const Duration(milliseconds: 400),
                    animatedIcon: AnimatedIcons.menu_close,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    children: [
                      SpeedDialChild(
                        child: const Icon(
                          Ionicons.qr_code,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        label: 'QR Scanner',
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => const QRScannerSheet(),
                          );
                        },
                      ),
                      SpeedDialChild(
                        child: const Icon(
                          Ionicons.create,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.blue,
                        label: 'Manual',
                        onTap: () {
                          // Implement your manual logic here
                        },
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
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
            const SizedBox(),
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
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
