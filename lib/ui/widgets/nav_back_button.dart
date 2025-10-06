import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBackButton extends StatefulWidget {
  const NavBackButton({super.key});

  @override
  State<NavBackButton> createState() => _NavBackButtonState();
}

class _NavBackButtonState extends State<NavBackButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => GoRouter.of(context).pop(),
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovered = true),
        onExit: (event) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          height: 40,
          width: 40,
          duration: Duration(
            milliseconds: 250,
          ),
          curve: Curves.bounceInOut,
          decoration: BoxDecoration(
            color: _isHovered ? Colors.grey.shade900 : theme.surface,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
      ),
    );
  }
}
