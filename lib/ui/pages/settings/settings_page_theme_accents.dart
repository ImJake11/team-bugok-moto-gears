import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class SettingsPageThemeAccents extends StatelessWidget {
  const SettingsPageThemeAccents({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<MyThemeProvider>();

    final accents = themeProvider.colorAccents;

    final selectedIndex = themeProvider.selectedIndex;

    return Column(
      children: List.generate(
        accents.length,
        (i) {
          final colors = accents[i].colors;

          final isSelected = selectedIndex == i;

          return GestureDetector(
            onTap: () => themeProvider.updateThemeColor(i),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.grey.shade900
                      : Theme.of(context).colorScheme.surfaceDim,
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
                              ? Theme.of(context).colorScheme.primary
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
