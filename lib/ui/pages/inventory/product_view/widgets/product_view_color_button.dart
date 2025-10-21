import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class ProductViewColorButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final GestureTapCallback onTap;

  const ProductViewColorButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<ProductViewColorButton> createState() => _ProductViewColorButtonState();
}

class _ProductViewColorButtonState extends State<ProductViewColorButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (event) =>
            setState(() => widget.isSelected ? null : _isHovered = true),
        onExit: (event) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.grey.shade900
                : theme.surfaceDim,
            border: Border.all(
              color: widget.isSelected
                  ? theme.primary
                  : theme.surface,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Text(
              widget.label,
            ),
          ),
        ),
      ),
    );
  }
}
