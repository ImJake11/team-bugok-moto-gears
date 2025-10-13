import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final Widget child;
  const CustomAppbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: child,
      ),
    );
  }
}
