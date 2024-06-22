import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required this.pageController,
    required this.tooltip,
    required this.icon,
    required this.selectedIcon,
    required this.iconSelected,
    required this.onPressed,
  });

  final PageController pageController;
  final ValueNotifier<bool> iconSelected;
  final String tooltip;
  final IconData icon;
  final IconData selectedIcon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: iconSelected,
      builder: (context, isSelected, child) {
        return IconButton(
          tooltip: tooltip,
          isSelected: isSelected,
          selectedIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                color: Theme.of(context).colorScheme.primary,
                size: 30,
                selectedIcon,
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          highlightColor: Colors.transparent,
          icon: Icon(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            icon,
            size: 30,
          ),
          onPressed: onPressed,
        );
      },
    );
  }
}
