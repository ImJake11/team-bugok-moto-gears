import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatefulWidget {
  final double width;
  final String placeholder;
  final IconData? suffixIcon;
  final List<TextInputFormatter>? formatter;
  final ValueChanged<String>? onChange;
  final TextEditingController? textEditingController;
  final bool? showShadow;
  final Color? fillColor;
  final int? maxLength;

  const CustomTextfield({
    super.key,
    this.width = 500,
    this.placeholder = "Search Product",
    this.suffixIcon,
    this.formatter,
    this.onChange,
    this.textEditingController,
    this.showShadow = true,
    this.fillColor = const Color(0xFF282828),
    this.maxLength = 10,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late TextEditingController _textEditingController;
  bool _isHovered = false;

  @override
  void initState() {
    _textEditingController =
        widget.textEditingController ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.textEditingController == null) {
      _textEditingController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: widget.showShadow ?? false
              ? [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(3, 3),
                    color: Colors.black54,
                  ),
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(-3, -3),
                    color: Colors.grey.shade800.withAlpha(120),
                  ),
                ]
              : [],
        ),
        width: widget.width,
        height: 50,
        child: TextField(
          
          maxLength: widget.maxLength,
          controller: _textEditingController,
          style: TextStyle(
            fontSize: 13,
          ),
          onChanged: widget.onChange,
          inputFormatters: widget.formatter ?? [],
          decoration: InputDecoration(
            counterText: "",
            fillColor: widget.fillColor,
            filled: true,
            contentPadding: EdgeInsets.all(5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary.withAlpha(200),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
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
