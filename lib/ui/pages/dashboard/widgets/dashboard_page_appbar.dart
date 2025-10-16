import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';

class DashboardPageAppbar extends StatelessWidget {
  const DashboardPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Hello, Welcome back!",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const Spacer(),
        CustomTextfield(
          fillColor: Theme.of(context).colorScheme.surfaceDim,
          suffixIcon: Icons.search_rounded,
        ),
      ],
    );
  }
}
