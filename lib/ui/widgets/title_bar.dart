import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/ui/widgets/widows_button.dart';
import 'package:team_bugok_business/utils/provider/sidebar_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatefulWidget {
  final bool showLogo;

  const TitleBar({super.key, this.showLogo = true});

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  bool _isMaximize = false;

  void _setMinimize() async {
    await windowManager.minimize();
  }

  void _setScreenSize() async {
    bool isMaximized = await windowManager.isMaximized();

    if (isMaximized) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }

    setState(() => _isMaximize = !_isMaximize);
  }

  void _setClose() async {
    await windowManager.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();
    final sidebar = context.watch<SidebarProvider>();

    bool isMinimized = sidebar.isMinimized;

    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (widget.showLogo)
              TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: 0,
                  end: isMinimized ? 0 : 100,
                ),
                duration: Duration(milliseconds: 200),
                builder: (context, value, child) {
                  return Transform(
                    transform: Matrix4.translationValues(0, value, 0),
                    child: Row(
                      spacing: 10,
                      children: [
                        Image.asset(
                          "assets/images/moto-gears-icon-no-bg.png",
                          width: 30,
                        ),
                        Text(
                          "Team Bugok Moto Gears",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            const Spacer(),
            CustomWindowButton(
              onClicked: () => _setMinimize(),
              icon: Icons.horizontal_rule_rounded,
              hoverColor: theme.primary,
            ),
            CustomWindowButton(
              onClicked: () => _setScreenSize(),
              icon: _isMaximize
                  ? Icons.fullscreen_exit_rounded
                  : Icons.square_outlined,
              hoverColor: theme.primary,
            ),
            CustomWindowButton(
              onClicked: () => _setClose(),
              icon: Icons.close_rounded,
              hoverColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
