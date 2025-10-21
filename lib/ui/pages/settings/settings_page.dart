import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/pages/settings/settings_page_change_password.dart';
import 'package:team_bugok_business/ui/pages/settings/settings_page_theme_accents.dart';
import 'package:team_bugok_business/ui/pages/settings/settings_page_wrapper.dart';
import 'package:team_bugok_business/ui/pages/settings/settins_references_value.dart';
import 'package:team_bugok_business/ui/pages/settings/widgets/setting_page_logout_button.dart';
import 'package:team_bugok_business/ui/widgets/appbar.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appbar = CustomAppbar(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Store Setup',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Customizing anything for your shop",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ],
      ),
    );

    return Column(
      spacing: 20,
      children: [
        appbar,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 50,
            ),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  SettingsPageWrapper(
                    icon: 'assets/images/palette.png',
                    title: "Color Accents",
                    child: SettingsPageThemeAccents(),
                    subTitle: "Customize how your system looks and feels.",
                  ),
                  SettingsPageWrapper(
                    icon: 'assets/images/price-tag.png',
                    title: "Brand Management",
                    subTitle:
                        "Manage the list of brands available in your system",
                    child: SettingsReferencesValue(
                      reference: ReferenceType.brands,
                    ),
                  ),
                  SettingsPageWrapper(
                    icon: 'assets/images/expand.png',
                    title: "Size Management",
                    subTitle:
                        "Control which sizes appear when adding new products.",
                    child: SettingsReferencesValue(
                      reference: ReferenceType.sizes,
                    ),
                  ),
                  SettingsPageWrapper(
                    icon: 'assets/images/apps.png',
                    title: "Category Management",
                    subTitle:
                        "Manage the list of product categories available in your system",
                    child: SettingsReferencesValue(
                      reference: ReferenceType.categories,
                    ),
                  ),
                  SettingsPageWrapper(
                    icon: 'assets/images/palette.png',
                    title: "Variants Color Management",
                    subTitle:
                        "Organize and maintain color variants for your products",
                    child: SettingsReferencesValue(
                      reference: ReferenceType.colors,
                    ),
                  ),
                  SettingsPageWrapper(
                    icon: '',
                    title: "Product Model Management",
                    subTitle: "Organize your product models",
                    child: SettingsReferencesValue(
                      reference: ReferenceType.models,
                    ),
                  ),
                  SettingsPageWrapper(
                    borderColor: Colors.red,
                    icon: 'assets/images/padlock.png',
                    title: "Change Pin",
                    subTitle: "Update your pin to keep your system secure",
                    child: SettingsPageChangePassword(),
                  ),
                
                  const SizedBox(height: 100),
                  SettingPageLogoutButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
