import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> entries;
  final String label;
  final double? width;
  final ValueChanged<String?>? onSelected;

  const CustomDropdown({
    super.key,
    required this.entries,
    required this.label,
    this.width = 400,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSelected: onSelected,
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
    );
  }
}
