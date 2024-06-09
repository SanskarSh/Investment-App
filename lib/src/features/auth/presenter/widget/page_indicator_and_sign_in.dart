import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investment_app/src/core/service/connectivity/cubit/internet_cubit.dart';
import 'package:investment_app/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:investment_app/src/features/auth/presenter/bloc/auth_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PageIndicatorAndSignIn extends StatefulWidget {
  const PageIndicatorAndSignIn({
    super.key,
    required this.onboardingPages,
    required this.currentPage,
    required this.pageController,
  });

  final List<Map<String, dynamic>> onboardingPages;
  final int currentPage;
  final PageController pageController;

  @override
  State<PageIndicatorAndSignIn> createState() => _PageIndicatorAndSignInState();
}

class _PageIndicatorAndSignInState extends State<PageIndicatorAndSignIn> {
  final authService = AuthServices();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _showLoginDialog(BuildContext context) {
    Future<void> login() async {
      final authService = AuthServices();

      Future.delayed(
        const Duration(seconds: 1),
        () {
          if (_formKey.currentState!.validate()) {
            Future.delayed(const Duration(seconds: 1), () async {
              try {
                String userName = usernameController.text;
                await authService
                    .signInWithEmailPassword(
                  "$userName@gmail.com",
                  passwordController.text,
                )
                    .then((value) {
                  Navigator.of(context).pop();
                });
              } catch (e) {
                Future.delayed(const Duration(seconds: 2), () {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: e.toString().split(":")[1].toUpperCase(),
                    ),
                  );
                });
              }
            });
          } else {}
        },
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: usernameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  onSaved: (email) {},
                  decoration: const InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Ionicons.mail_outline,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  onSaved: (password) {},
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Ionicons.key_outline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AuthBloc>(context),
      builder: (context, states) {
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOutCubicEmphasized,
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: widget.onboardingPages[widget.currentPage]['color'],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmoothPageIndicator(
                  effect: WormEffect(
                    radius: 8.0,
                    spacing: 10.0,
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    strokeWidth: 0.0,
                    dotColor:
                        Theme.of(context).colorScheme.primary.withOpacity(.4),
                    type: WormType.thin,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                  ),
                  controller: widget.pageController,
                  count: widget.onboardingPages.length,
                ),
                const SizedBox(height: 10.0),
                Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          const Size(double.infinity, 60),
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
                        BlocProvider.of<AuthBloc>(context)
                            .add(SignInRequested());
                      },
                      child: BlocBuilder<InternetCubit, InternetState>(
                        builder: (context, state) {
                          if (state.isConnected) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Ionicons.logo_google,
                                  color: Colors.white,
                                ),
                                Container(
                                  height: 30.0,
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () => _showLoginDialog(context),
                      child: Text(
                        "login with email",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16.0,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
