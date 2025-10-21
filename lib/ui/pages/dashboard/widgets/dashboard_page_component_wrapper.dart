import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class DashboardComponentWrapper extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final Widget child;
  final List<Color>? gradientColors;

  const DashboardComponentWrapper({
    super.key,
    required this.title,
    this.height = 400,
    this.width = 300,
    required this.child,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    List<Color> colors = gradientColors?.isEmpty ?? true
        ? [theme.surfaceDim, theme.surfaceDim]
        : gradientColors!;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.surfaceDim,
        border: Border.all(
          color: theme.borderColor,
        ),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: theme.shadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
