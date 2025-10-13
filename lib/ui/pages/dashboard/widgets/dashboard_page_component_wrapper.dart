import 'package:flutter/material.dart';

class DashboardComponentWrapper extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final Widget child;
  const DashboardComponentWrapper({
    super.key,
    required this.title,
    this.height = 400,
    this.width = 300,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surfaceDim,
        border: Border.all(
          color: Color(0xFF555555),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(3, 3),
            color: Colors.black,
          ),
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(-3, -3),
            color: Colors.grey.shade800.withAlpha(120),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
