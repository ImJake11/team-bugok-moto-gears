import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class AuthPageLeftSide extends StatelessWidget {
  const AuthPageLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.clamp,
            colors: [
              theme.primary,
              theme.primary,
              theme.secondary,
              theme.secondary,
              theme.tertiary,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Built for speed. Designed for control.',
                style: GoogleFonts.poppins(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.grey.shade800,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              Text(
                '''Engineered for champions who don’t just race — they dominate. Every tap, every turn, every second counts. Welcome to the cockpit of precision.
              ''',
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 18,
                  fontFeatures: [
                    FontFeature.caseSensitiveForms(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
