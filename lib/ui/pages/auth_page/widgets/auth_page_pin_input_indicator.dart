import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';

class AuthPagePinInputIndicator extends StatelessWidget {
  final bool isContained;
  

  const AuthPagePinInputIndicator({super.key, required this.isContained});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final provider = context.read<AuthProvider>();

    final hasError = provider.hasError;
    final isLoggedIn = provider.isLoggedIn;

    return Container(
      width: 20,
      height: 20,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1,
          color: hasError
              ? Colors.red
              : isLoggedIn
              ? Colors.green
              : Colors.grey.shade800,
        ),
      ),
      child: TweenAnimationBuilder(
        tween: Tween<double>(
          begin: 0,
          end: isContained ? 1 : 0,
        ),
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    theme.primary,
                    theme.secondary,
                    theme.tertiary,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
