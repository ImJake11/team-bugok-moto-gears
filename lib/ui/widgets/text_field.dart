import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({super.key});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  double? width = 500;
  String? placeholder = "Search Product";
  IconData? suffixIcon = LucideIcons.search;

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.grey.shade900 : theme.surface,
          borderRadius: BorderRadius.circular(10),
          border: BoxBorder.all(
            width: _isHovered ? 2 : 1,
            style: BorderStyle.solid,
            color: theme.primary,
          ),
        ),
        width: width,
        height: 50,
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey.shade700),
            prefixIcon: Icon(suffixIcon, color: theme.primary, size: 20),
          ),
        ),
      ),
    );
  }
}
