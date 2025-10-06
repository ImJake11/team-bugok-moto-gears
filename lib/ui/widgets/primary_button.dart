import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Widget child;
  final double width;
  final GestureTapCallback? onTap;

  const CustomButton({
    super.key,
    required this.child,
    this.width = 150,
    this.onTap,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: widget.width,
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
          child: widget.child,
        ),
      ),
    );
  }
}
