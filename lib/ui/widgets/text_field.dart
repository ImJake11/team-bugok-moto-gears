import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatefulWidget {
  final double width;
  final String placeholder;
  final IconData? suffixIcon;
  final List<TextInputFormatter>? formatter;
  final ValueChanged<String>? onChange;

  const CustomTextfield({
    super.key,
    this.width = 500,
    this.placeholder = "Search Product",
    this.suffixIcon,
    this.formatter,
    this.onChange,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
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
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    blurRadius: 3,
                    color: theme.primary,
                    offset: Offset(2, 2),
                  ),
                  BoxShadow(
                    blurRadius: 3,
                    color: theme.primary,
                    offset: Offset(-2, -2),
                  ),
                ]
              : [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.black,
                    offset: Offset(2, 2),
                  ),
                ],
        ),
        width: widget.width,
        height: 50,
        child: TextField(
          onChanged: widget.onChange,
          autofocus: true,
          inputFormatters: widget.formatter ?? [],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            hintText: widget.placeholder,
            hintStyle: TextStyle(color: Colors.grey.shade700),
            prefixIcon: widget.suffixIcon != null
                ? Icon(widget.suffixIcon, color: theme.primary, size: 20)
                : null,
          ),
        ),
      ),
    );
  }
}
