import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment_app/src/core/service/connectivity/cubit/internet_cubit.dart';
import 'package:investment_app/src/features/auth/presenter/bloc/auth_bloc.dart';
import 'package:investment_app/src/features/auth/presenter/widget/page_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                    buildPageView(),
                    buildPageNavigationButtons(context)
                  ],
                ),
              ),
              buildPageIndicator(context)
            ],
          ),
        ),
      ),
    );
  }

  PageView buildPageView() {
    return PageView.builder(
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

  Expanded buildPageIndicator(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOutCubicEmphasized,
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: onboardingPages[currentPage]['color'],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthError) {
                  print(state.message);
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(state.message),
                  //     ),
                  //   );
                }
                if (state is Authenticated) {
                  return const Placeholder();
                } else {
                  return ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 70),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(SignInRequested());
                    },
                    child: BlocBuilder<InternetCubit, InternetState>(
                      builder: (context, state) {
                        if (state.isConnected) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'SignIn With Google',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 20.0,
                                ),
                              ),
                              const Icon(
                                Ionicons.logo_google,
                                color: Colors.white,
                              )
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
              },
            ),
            SmoothPageIndicator(
              effect: WormEffect(
                radius: 8.0,
                spacing: 10.0,
                dotWidth: 10.0,
                dotHeight: 10.0,
                strokeWidth: 0.0,
                dotColor: Theme.of(context).colorScheme.primary.withOpacity(.4),
                type: WormType.thin,
                activeDotColor: Theme.of(context).colorScheme.primary,
              ),
              controller: pageController,
              count: onboardingPages.length,
            ),
          ],
        ),
      ),
    );
  }
}
