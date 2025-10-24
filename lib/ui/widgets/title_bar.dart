import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/ui/widgets/date_time_display.dart';
import 'package:team_bugok_business/ui/widgets/widows_button.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatefulWidget {
  const TitleBar({super.key});

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
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
  }

  void _setClose() async {
    await windowManager.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<MyThemeProvider>();

    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomWindowButton(
              onClicked: () => _setMinimize(),
              icon: Icons.horizontal_rule_rounded,
              hoverColor: theme.primary,
            ),
            CustomWindowButton(
              onClicked: () => _setScreenSize(),
              icon: Icons.square_outlined,
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
