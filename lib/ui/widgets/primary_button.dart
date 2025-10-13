import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Widget child;
  final double width;
  final GestureTapCallback? onTap;
  final double borderRadius;
  final double height;

  const CustomButton({
    super.key,
    required this.child,
    this.width = 150,
    this.onTap,
    this.height = 50,
    this.borderRadius = 10,
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
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: _isHovered ? [0.0, 0.5, 1.0] : [0.1, 0.3, 0.6],
              colors: [theme.tertiary, theme.secondary, theme.primary],
            ),
            boxShadow: [
               BoxShadow(
                color: Colors.grey.shade800.withAlpha(120),
                blurRadius: 3,
                spreadRadius: 3,
                offset: const Offset(-3, -3),
              ),
              BoxShadow(
                color: Colors.black54,
                blurRadius: 3,
                spreadRadius: 3,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
