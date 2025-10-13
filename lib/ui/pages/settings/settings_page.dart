import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/pages/settings/settings_page_theme_accents.dart';
import 'package:team_bugok_business/ui/pages/settings/settings_page_wrapper.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SettingsPageWrapper(
            icon: 'assets/images/palette.png',
            title: "System Accent",
            child: SettingsPageThemeAccents(),
          ),
        ],
      ),
    );
  }
}
