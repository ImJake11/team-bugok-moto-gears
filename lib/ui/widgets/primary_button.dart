import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class CustomButton extends StatefulWidget {
  final Widget child;
  final double width;
  final GestureTapCallback? onTap;
  final double borderRadius;
  final double height;
  final bool? showShadow;

  const CustomButton({
    super.key,
    required this.child,
    this.width = 150,
    this.onTap,
    this.height = 50,
    this.borderRadius = 10,
    this.showShadow = true,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

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
            boxShadow: (widget.showShadow ?? false) ? theme.shadow : [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
