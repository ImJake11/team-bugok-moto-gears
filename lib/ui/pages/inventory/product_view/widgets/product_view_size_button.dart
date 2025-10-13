import 'package:flutter/material.dart';

class ProductViewSizeButton extends StatefulWidget {
  final String label;
  final bool isAvailable;
  final int stock;
  final GestureTapCallback? onTap;
  final bool showHoverAnimation;

  const ProductViewSizeButton({
    super.key,
    this.onTap,
    required this.label,
    required this.isAvailable,
    required this.stock,
    this.showHoverAnimation = false,
  });

  @override
  State<ProductViewSizeButton> createState() => _ProductViewSizeButtonState();
}

class _ProductViewSizeButtonState extends State<ProductViewSizeButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
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
                  ? Theme.of(context).colorScheme.secondary
                  : !widget.showHoverAnimation && widget.isAvailable
                  ? Theme.of(context).colorScheme.primary
                  : Colors.black,
            ),
            color: widget.isAvailable
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.surfaceDim,
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
