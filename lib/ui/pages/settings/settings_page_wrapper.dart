import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class SettingsPageWrapper extends StatefulWidget {
  final String title;
  final Widget child;
  final String icon;
  final String subTitle;
  final Color? borderColor;

  const SettingsPageWrapper({
    super.key,
    this.borderColor,
    required this.title,
    required this.child,
    required this.icon,
    required this.subTitle,
  });

  @override
  State<SettingsPageWrapper> createState() => _SettingsPageWrapperState();
}

class _SettingsPageWrapperState extends State<SettingsPageWrapper> {
  bool _isCollapsed = false;
  bool _isHovered = false;
  bool _isArrowButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    final borderColor = widget.borderColor ?? theme.borderColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isHovered ? theme.primary : borderColor,
          ),
          color: Colors.black26,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 10,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.subTitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: 0,
                      end: _isCollapsed ? 3.2 : 0,
                    ),
                    duration: Duration(milliseconds: 300),
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value,
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _isCollapsed = !_isCollapsed),
                          child: MouseRegion(
                            onEnter: (_) =>
                                setState(() => _isArrowButtonHovered = true),
                            onExit: (_) =>
                                setState(() => _isArrowButtonHovered = false),
                            child: Tooltip(
                              message: "View Content",
                              child: AnimatedContainer(
                                width: 40,
                                height: 40,
                                duration: Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: _isArrowButtonHovered
                                      ? Colors.grey.shade900
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 30,
                                  color: theme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.linear,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: _isCollapsed
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          top: 20,
                        ),
                        child: widget.child,
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
