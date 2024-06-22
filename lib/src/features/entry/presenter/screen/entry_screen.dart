import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:investment_app/src/features/entry/presenter/widget/todo_task_sheet.dart';
import 'package:investment_app/src/features/explore_feed/presenter/screen/explore_screen.dart';
import 'package:investment_app/src/features/entry/presenter/widget/add_blog_sheet.dart';
import 'package:investment_app/src/features/entry/presenter/widget/chat_screen.dart';
import 'package:investment_app/src/features/entry/presenter/widget/manual_expense_sheet.dart';
import 'package:investment_app/src/features/entry/presenter/widget/navigation_button.dart';
import 'package:investment_app/src/features/home/presenter/screen/home_screen.dart';
import 'package:investment_app/src/features/entry/presenter/widget/qr_scanner.dart';
import 'package:investment_app/src/features/leaderboard/presenter/screen/leaderboard_screen.dart';
import 'package:investment_app/src/features/profile/presenter/screen/profile_screen.dart';
import 'package:ionicons/ionicons.dart';

class EntryScreen extends StatelessWidget {
  EntryScreen({super.key});

  final ValueNotifier<bool> homeSelected = ValueNotifier(true);
  final ValueNotifier<bool> blogSelected = ValueNotifier(false);
  final ValueNotifier<bool> profileSelected = ValueNotifier(false);
  final ValueNotifier<bool> leaderBoardSelected = ValueNotifier(false);
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
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
          ExploreScreen(),
          LeaderBoardScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
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
                leaderBoardSelected.value = false;
                profileSelected.value = false;
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
                leaderBoardSelected.value = false;
                profileSelected.value = false;
              },
            ),
            ValueListenableBuilder(
                valueListenable: leaderBoardSelected,
                builder: (_, __, ___) {
                  return ValueListenableBuilder(
                      valueListenable: homeSelected,
                      builder: (_, __, ___) {
                        return ValueListenableBuilder(
                          valueListenable: blogSelected,
                          builder: (_, __, ___) {
                            if (homeSelected.value) {
                              return SpeedDial(
                                elevation: 0,
                                animationDuration:
                                    const Duration(milliseconds: 400),
                                animatedIcon: AnimatedIcons.menu_close,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                activeBackgroundColor:
                                    Theme.of(context).colorScheme.secondary,
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
                                        builder: (context) =>
                                            const QRScannerSheet(),
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
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            ManualExpenseSheet(),
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else if (blogSelected.value) {
                              return FloatingActionButton(
                                elevation: 0.0,
                                shape: const CircleBorder(),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                child: const Icon(Ionicons.add),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => const AddBlogSheet(),
                                  );
                                },
                              );
                            } else if (leaderBoardSelected.value) {
                              return FloatingActionButton(
                                elevation: 0.0,
                                shape: const CircleBorder(),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                child: const Icon(
                                  Ionicons.today_outline,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => const TodoTaskSheet(),
                                  );
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        );
                      });
                }),
            NavigationButton(
              pageController: pageController,
              tooltip: "Leader Board",
              icon: Ionicons.stats_chart_outline,
              selectedIcon: Ionicons.stats_chart,
              iconSelected: leaderBoardSelected,
              onPressed: () {
                pageController.jumpToPage(2);
                homeSelected.value = false;
                blogSelected.value = false;
                leaderBoardSelected.value = true;
                profileSelected.value = false;
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
                pageController.jumpToPage(3);
                homeSelected.value = false;
                blogSelected.value = false;
                leaderBoardSelected.value = false;
                profileSelected.value = true;
              },
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
