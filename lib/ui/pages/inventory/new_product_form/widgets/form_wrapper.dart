import 'package:flutter/material.dart';

class FormWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final double bottomBorderRadius;
  final double topBorderRadius;
  final Widget? suffixWidget;

  const FormWrapper({
    super.key,
    required this.title,
    required this.child,
    this.bottomBorderRadius = 0,
    this.topBorderRadius = 0,
    this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bottomBorderRadius),
          bottomRight: Radius.circular(bottomBorderRadius),
          topLeft: Radius.circular(topBorderRadius),
          topRight: Radius.circular(topBorderRadius),
        ),
        color: Theme.of(context).colorScheme.surfaceDim,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 15,
        ),
        child: Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Expanded(child: SizedBox()),
                if (suffixWidget != null) suffixWidget!,
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
