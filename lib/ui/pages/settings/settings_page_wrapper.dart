import 'package:flutter/material.dart';

class SettingsPageWrapper extends StatefulWidget {
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
  State<SettingsPageWrapper> createState() => _SettingsPageWrapperState();
}

class _SettingsPageWrapperState extends State<SettingsPageWrapper> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isCollapsed = !_isCollapsed),
      child: Container(
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
                    widget.icon,
                    width: 18,
                    colorBlendMode: BlendMode.srcIn,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 30,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              if (_isCollapsed)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: widget.child,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
