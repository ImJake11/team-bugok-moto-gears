import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class ProductViewRelatedButton extends StatefulWidget {
  final String brand;
  final String model;
  const ProductViewRelatedButton({
    super.key,
    required this.brand,
    required this.model,
  });

  @override
  State<ProductViewRelatedButton> createState() =>
      _ProductViewRelatedButtonState();
}

class _ProductViewRelatedButtonState extends State<ProductViewRelatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: theme.surfaceDim,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isHovered ? theme.primary : theme.borderColor,
          ),
          boxShadow: theme.shadow,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: Colors.grey.shade700,
                      end: _isHovered
                          ? theme.primary
                          : Colors.grey.shade700, // 🎨 target color
                    ),
                    duration: const Duration(milliseconds: 200),
                    builder: (context, color, child) {
                      return Text(
                        widget.brand,
                        style: TextStyle(
                          fontSize: 16,
                          color: color,
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: _isHovered ? 0 : 100,
                    ),
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 300),
                    builder: (context, offset, child) {
                      return Transform(
                        transform: Matrix4.translationValues(0, offset, 0),
                        child: Text(
                          "View",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
