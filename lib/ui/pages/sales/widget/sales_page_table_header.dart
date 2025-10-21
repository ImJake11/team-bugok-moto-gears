import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

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
    final theme = context.watch<MyThemeProvider>();

    return Flexible(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isDarkenBg
              ? Colors.black
              : theme.surfaceDim,
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
