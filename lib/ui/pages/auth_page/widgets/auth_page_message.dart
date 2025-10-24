import 'package:flutter/material.dart';

class AuthPageMessage extends StatelessWidget {
  final bool hasError;
  final bool isLoggedIn;
  final String message;

  const AuthPageMessage({
    super.key,
    required this.hasError,
    required this.isLoggedIn,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return SizedBox();

    Color color = hasError
        ? Colors.red
        : isLoggedIn
        ? Colors.green
        : Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          message,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
