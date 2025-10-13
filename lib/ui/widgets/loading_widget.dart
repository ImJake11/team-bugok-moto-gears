import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        LoadingAnimationWidget.discreteCircle(
          secondRingColor: theme.secondary,
          color: theme.primary,
          thirdRingColor: Colors.grey.shade700,
          size: 40,
        ),
        Text("Please wait...")
      ],
    );
  }
}
