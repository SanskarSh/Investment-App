import 'package:flutter/material.dart';
import 'package:investment_app/injection_container.dart';
import 'package:investment_app/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:ionicons/ionicons.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:investment_app/src/config/controller/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: Center(
              child: Text(
                "Profile Screen",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    SizedBox(height: 60, child: RandomAvatar("Profile")),
                    const SizedBox(height: 16),
                    Text(
                      "User Name",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.8),
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w200,
                          ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.notifications_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "Notifcations",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const Spacer(),
                        Icon(
                          Ionicons.chevron_forward_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.settings_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "Settings",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const Spacer(),
                        Icon(
                          Ionicons.chevron_forward_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    const Spacer(),
                    const ToggleTheme(),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => _auth.signOut(),
                      child: Row(
                        children: [
                          Icon(
                            Ionicons.log_out_outline,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "Log Out",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32)
        ],
      ),
    );
  }
}

class ToggleTheme extends StatefulWidget {
  const ToggleTheme({super.key});

  @override
  State<ToggleTheme> createState() => _ToggleThemeState();
}

class _ToggleThemeState extends State<ToggleTheme> {
  late bool _switch;

  @override
  void initState() {
    super.initState();
    final settingsController = si<SettingsController>();
    _switch = settingsController.themeMode == ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    final settingsController = si<SettingsController>();

    return GestureDetector(
      onTap: () {
        setState(() {
          _switch = !_switch;
          settingsController.updateThemeMode(
            _switch ? ThemeMode.dark : ThemeMode.light,
          );
        });
      },
      child: Row(
        children: [
          _switch
              ? Icon(
                  Icons.dark_mode,
                  color: Theme.of(context).colorScheme.primary,
                )
              : Icon(
                  Icons.light_mode,
                  color: Theme.of(context).colorScheme.secondary,
                ),
          const SizedBox(width: 16),
          Text(
            _switch ? "Dark Mode" : "Light Mode",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
