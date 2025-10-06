import 'package:flutter/material.dart';

class FormWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final double bottomBorderRadius;
  final double topBorderRadius;

  const FormWrapper({
    super.key,
    required this.title,
    required this.child,
    this.bottomBorderRadius = 0,
    this.topBorderRadius = 0,
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
        color: Color(0xFF121212),
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
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
