import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class AuthPagePinButton extends StatefulWidget {
  final String label;
  final int index;
  final bool isPressed;

  const AuthPagePinButton({
    super.key,
    required this.label,
    required this.index,
    required this.isPressed,
  });

  @override
  State<AuthPagePinButton> createState() => _AuthPagePinButtonState();
}

class _AuthPagePinButtonState extends State<AuthPagePinButton> {
  bool _isHovered = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthProvider>().checkUserSession();
  }

  @override
  void didUpdateWidget(covariant AuthPagePinButton oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPressed != widget.isPressed) {
      _showFeedPressedFeedback();
    }
  }

  void _showFeedPressedFeedback() async {
    setState(() => _isHovered = true);
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => _isHovered = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return GestureDetector(
      onTap: () {
        final auth = context.read<AuthProvider>();

        widget.index == 9
            ? auth.deleteLast()
            : auth.addInput(int.parse(widget.label));
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 5,
            left: 10,
            right: 10,
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isHovered
                  ? theme.primary.withAlpha(50)
                  : theme.surfaceDim,
              border: Border.all(
                color: Colors.grey.shade800,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade900,
                  blurRadius: 5,
                  spreadRadius: 3,
                  offset: Offset(-3, -3),
                ),
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5,
                  spreadRadius: 3,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1, end: _isHovered ? 1.3 : 1),
                duration: Duration(milliseconds: 250),
                builder: (context, value, child) => Transform.scale(
                  scale: value,
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
