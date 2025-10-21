import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/utils/constants/theme_colors.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class SettingsPageThemeAccents extends StatelessWidget {
  const SettingsPageThemeAccents({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<MyThemeProvider>();

    final accents = colorAccents;

    final selectedIndex = themeProvider.selectedIndex;

    return Column(
      spacing: 5,
      children: List.generate(
        accents.length,
        (i) {
          final colors = accents[i].colors;

          final isSelected = selectedIndex == i;

          return GestureDetector(
            onTap: () {
              Provider.of<MyThemeProvider>(
                context,
                listen: false,
              ).updateThemeColor(i);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? themeProvider.primary
                        : themeProvider.borderColor,
                  ),

                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Text(
                        accents[i].name,
                        style: TextStyle(
                          color: isSelected
                              ? themeProvider.primary
                              : Colors.white,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: isSelected ? 16 : 14,
                        ),
                      ),
                      const Spacer(),

                      ...List.generate(
                        colors.length,
                        (index) {
                          return Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              color: colors[index],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
