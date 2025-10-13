import 'package:flutter/material.dart';

class SettingsPageWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final String icon;

  const SettingsPageWrapper({
    super.key,
    required this.title,
    required this.child,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceDim,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 25,
        ),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                Image.asset(
                  icon,
                  width: 20,
                  colorBlendMode: BlendMode.srcIn,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
