import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class ProductViewSizeButton extends StatefulWidget {
  final String label;
  final bool isAvailable;
  final int stock;
  final GestureTapCallback? onTap;
  final bool showHoverAnimation;
  final bool? isInActive;

  const ProductViewSizeButton({
    super.key,
    this.onTap,
    required this.label,
    required this.isAvailable,
    required this.stock,
    this.showHoverAnimation = false,
    this.isInActive = false,
  });

  @override
  State<ProductViewSizeButton> createState() => _ProductViewSizeButtonState();
}

class _ProductViewSizeButtonState extends State<ProductViewSizeButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final  theme = context.watch<MyThemeProvider>();

    if (widget.isInActive ?? false) return const SizedBox();

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (event) => setState(
          () => (widget.showHoverAnimation) ? _isHover = true : false,
        ),
        onExit: (event) => setState(() => _isHover = false),
        child: AnimatedContainer(
          constraints: BoxConstraints(
            minWidth: 50,
          ),
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHover
                  ? theme.secondary
                  : !widget.showHoverAnimation && widget.isAvailable
                  ? theme.primary
                  : Colors.black,
            ),
            color: widget.isAvailable
                ? theme.surface
                : theme.surfaceDim,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              spacing: 10,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.isAvailable)
                  Text(
                    widget.stock.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
