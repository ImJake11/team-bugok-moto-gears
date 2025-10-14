import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> entries;
  final String label;
  final double? width;
  final ValueChanged<String?>? onSelected;
  final String? selectedValue;

  const CustomDropdown({
    super.key,
    required this.entries,
    required this.label,
    this.width = 400,
    this.onSelected,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
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
            color: Color(0xFF555555),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF555555),
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
    );
  }
}
