import 'package:flutter/material.dart';

class NewProductButton extends StatefulWidget {
  const NewProductButton({super.key});

  @override
  State<NewProductButton> createState() => _NewProductButtonState();
}

class _NewProductButtonState extends State<NewProductButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: _isHovered ? [0.0, 0.5, 1.0] : [0.1, 0.3, 0.6],
            colors: [theme.tertiary, theme.secondary, theme.primary],
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: theme.primary.withAlpha(20),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Image.asset(
              "assets/images/helmet.png",
              width: 20,
              color: Colors.white,
              colorBlendMode: BlendMode.srcIn,
            ),
            Text(
              "New Gear",
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
