import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class CustomTextfield extends StatefulWidget {
  final double width;
  final String placeholder;
  final IconData? suffixIcon;
  final List<TextInputFormatter>? formatter;
  final ValueChanged<String>? onChange;
  final void Function()? onSuffixClick;
  final TextEditingController? textEditingController;
  final bool? showShadow;
  final Color? fillColor;
  final int? maxLength;
  final double? height;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool showSuffixIcon;

  const CustomTextfield({
    this.onSuffixClick,
    this.showSuffixIcon = false,
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
    this.height = 40,
    this.maxLines = 1,
    this.textAlign,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late TextEditingController _textEditingController;

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
    final theme = context.watch<MyThemeProvider>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: widget.showShadow ?? false ? theme.shadow : [],
      ),
      width: widget.width,
      height: widget.height,
      child: TextField(
        textAlign: widget.textAlign ?? TextAlign.left,
        maxLines: widget.maxLines,
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
              color: theme.primary.withAlpha(200),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: theme.primary,
            ),
          ),
          hintText: widget.placeholder,
          hintStyle: TextStyle(color: Colors.grey.shade700),
          suffixIcon: widget.showSuffixIcon
              ? GestureDetector(
                  onTap: widget.onSuffixClick,
                  child: Icon(
                    Icons.close_rounded,
                    size: 20,
                  ),
                )
              : null,
          prefixIcon: widget.suffixIcon != null
              ? Icon(widget.suffixIcon, color: theme.primary, size: 20)
              : null,
        ),
      ),
    );
  }
}
