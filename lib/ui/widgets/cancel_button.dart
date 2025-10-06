import 'package:flutter/material.dart';

class CancelButton extends StatefulWidget {
  const CancelButton({super.key});

  @override
  State<CancelButton> createState() => _CancelButtonState();
}

class _CancelButtonState extends State<CancelButton> {
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
          border: BoxBorder.all(
            color: Colors.grey.shade800,
          ),
          color: _isHovered ? Colors.grey.shade800 : theme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text("Cancel"),
        ),
      ),
    );
  }
}
