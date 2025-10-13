import 'package:flutter/material.dart';

class SalesPageTableHeader extends StatelessWidget {
  final String label;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final bool isDarkenBg;

  const SalesPageTableHeader({
    super.key,
    required this.label,
    this.borderRadiusGeometry,
    this.isDarkenBg = true,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isDarkenBg
              ? Theme.of(context).colorScheme.surfaceDim
              : Theme.of(context).colorScheme.surface,
          borderRadius: borderRadiusGeometry,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
