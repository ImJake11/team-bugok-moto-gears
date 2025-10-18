import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/pages/settings/settings_page_theme_accents.dart';
import 'package:team_bugok_business/ui/pages/settings/settings_page_wrapper.dart';
import 'package:team_bugok_business/ui/pages/settings/settins_references_value.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            SettingsPageWrapper(
              icon: 'assets/images/palette.png',
              title: "System Accent",
              child: SettingsPageThemeAccents(),
            ),
            SettingsPageWrapper(
              icon: 'assets/images/price-tag.png',
              title: "Customize Available Brands",
              child: SettingsReferencesValue(
                reference: ReferenceType.brands,
              ),
            ),
            SettingsPageWrapper(
              icon: 'assets/images/expand.png',
              title: "Customize Available Sizes",
              child: SettingsReferencesValue(
                reference: ReferenceType.sizes,
              ),
            ),
            SettingsPageWrapper(
              icon: 'assets/images/apps.png',
              title: "Customize Available Categories",
              child: SettingsReferencesValue(
                reference: ReferenceType.categories,
              ),
            ),
            SettingsPageWrapper(
              icon: 'assets/images/palette.png',
              title: "Customize Available Colors",
              child: SettingsReferencesValue(
                reference: ReferenceType.colors,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
