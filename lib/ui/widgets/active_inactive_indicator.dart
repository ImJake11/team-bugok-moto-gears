import 'package:flutter/material.dart';

class ActiveInactiveIndicator extends StatelessWidget {
  final bool isActive;

  const ActiveInactiveIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    var bgColor = isActive ? Colors.lightGreen : Colors.grey.shade800;

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            isActive ? "Active" : "Inactive",
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
