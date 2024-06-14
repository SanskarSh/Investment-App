import 'package:flutter/material.dart';
import 'package:investment_app/src/features/auth/presenter/widget/page_indicator_and_sign_in.dart';
import 'package:investment_app/src/features/auth/presenter/widget/page_widget.dart';
import 'package:ionicons/ionicons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  int currentPage = 0;

  final List<Map<String, dynamic>> onboardingPages = [
    {
      'color': Colors.teal.shade200.withOpacity(.6),
      'title': 'Investing for everyone',
      'description':
          'Investing has never been easier. With our app, you can start investing in stocks, ETFs, and options with as little as 1.',
    },
    {
      'color': Colors.orangeAccent.shade200.withOpacity(.6),
      'title': 'Learn as you go',
      'description':
          'Download the app and learn as you go. We have a library of educational content to help you make informed decisions.',
    },
    {
      'color': Colors.blue.shade200.withOpacity(.6),
      'title': 'Manage your portfolio',
      'description':
          'Keep tabs on your portfolio with our easy-to-use app. You can check your investments and make trades at any time.',
    },
    {
      'color': Colors.deepPurple.shade100.withOpacity(.6),
      'title': 'Get started today',
      'description':
          'Ready to get started? Download the app and start investing today.',
    },
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      controller: pageController,
                      itemCount: onboardingPages.length,
                      itemBuilder: (context, index) {
                        return PageViewWidget(
                          color: onboardingPages[index]['color'],
                          title: onboardingPages[index]['title'],
                          description: onboardingPages[index]['description'],
                        );
                      },
                    ),
                    buildPageNavigationButtons(context)
                  ],
                ),
              ),
              PageIndicatorAndSignIn(
                onboardingPages: onboardingPages,
                currentPage: currentPage,
                pageController: pageController,
              )
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildPageNavigationButtons(BuildContext context) {
    return Positioned(
      bottom: 20.0,
      left: 20.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Row(
          children: [
            if (currentPage != 0) ...[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(
                    Ionicons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
            const SizedBox(width: 20.0),
            if (currentPage != onboardingPages.length - 1) ...[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(
                    Ionicons.arrow_forward,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
