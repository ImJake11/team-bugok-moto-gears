import 'package:flutter/material.dart';

class PaddingWrapper extends StatelessWidget {
  final Widget child;

  const PaddingWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(right: 15, bottom: 15, left: 5, top: 5),
      child: child,
    );
  }
}
