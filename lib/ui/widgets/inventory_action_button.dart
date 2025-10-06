import 'package:flutter/material.dart';

class InventoryActionButtons extends StatefulWidget {
  final String label;
  final IconData icon;
  const InventoryActionButtons({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  State<InventoryActionButtons> createState() => _InventoryActionButtonsState();
}

class _InventoryActionButtonsState extends State<InventoryActionButtons> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    var icon = Icon(widget.icon, color: Colors.white);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: _isHovered ? 120 : 50,
        height: 50,
        decoration: BoxDecoration(
          border: BoxBorder.all(color: theme.primary),
          borderRadius: BorderRadius.circular(10),
          color: theme.surface,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    blurRadius: 3,
                    color: theme.primary,
                    offset: Offset(2, 2),
                  ),
                  BoxShadow(
                    blurRadius: 3,
                    color: theme.primary,
                    offset: Offset(-2, -2),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: _isHovered ? 10 : 0,
          children: [
            icon,
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              opacity: _isHovered ? 1.0 : 0.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: _isHovered ? 60 : 0, // smooth text width
                child: Text(
                  _isHovered ? widget.label : "",
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
