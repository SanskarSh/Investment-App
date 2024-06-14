
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
          selectedIcon: Icon(
            color: Theme.of(context).colorScheme.secondary,
            size: 30,
            selectedIcon,
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
