import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/widgets/loading_overlay.dart';
import 'package:team_bugok_business/ui/widgets/sidebar.dart';

class GlobalWrapper extends StatelessWidget {
  final Widget child;

  const GlobalWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Row(
            children: [
              Sidebar(),
              Expanded(
                child: child,
              ),
            ],
          ),
          LoadingOverlay(),
        ],
      ),
    );
  }
}
