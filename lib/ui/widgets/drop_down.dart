import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> entries;
  final String label;
  final double? width;
  final ValueChanged<String?>? onSelected;
  final String? selectedValue;
  final bool showDecoration;

  const CustomDropdown({
    super.key,
    required this.entries,
    required this.label,
    this.width = 400,
    this.onSelected,
    this.selectedValue,
    this.showDecoration = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return Container(
      decoration: showDecoration
          ? BoxDecoration(
              color: theme.surfaceDim,
              borderRadius: BorderRadius.circular(10),
              boxShadow: theme.shadow,
            )
          : null,
      child: DropdownMenu(
        textStyle: TextStyle(
          fontSize: 13,
        ),
        menuStyle: MenuStyle(
          side: WidgetStatePropertyAll(
            BorderSide(
              color: Color(0xFF555555),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onSelected: onSelected,
        initialSelection: selectedValue,
        hintText: label,
        width: width,
        enableSearch: true,
        enableFilter: true,
        menuHeight: 400,
        dropdownMenuEntries: entries.map((etnry) {
          return DropdownMenuEntry(
            value: etnry,
            label: etnry,
          );
        }).toList(),
      ),
    );
  }
}
