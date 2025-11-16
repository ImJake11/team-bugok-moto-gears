import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/utils/provider/sidebar_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    final routeName = GoRouter.of(context).state.name;
    final theme = context.watch<MyThemeProvider>();
    final sidebar = context.watch<SidebarProvider>();

    bool isMinimized = sidebar.isMinimized;
    final buttonsData = sidebar.buttonsData;

    final double sidebarWidth = isMinimized ? 100 : 270;

    final route = GoRouter.of(context).state.name;

    bool isHide = route == 'new-product-form';

    if (isHide) return const SizedBox();

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: sidebarWidth,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.surfaceDim,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Column(
            spacing: 10,
            children: [
              if (!isMinimized)
                SizedBox(
                  height: 100,
                  child: Image.asset(
                    width: sidebarWidth * .55,
                    "assets/images/moto-gears-icon-no-bg.png",
                    fit: BoxFit.cover,
                  ),
                )
              else
                const SizedBox(height: 35),
              const SizedBox(height: 20),
              ...List.generate(
                buttonsData.length,
                (index) => SidebarButton(
                  isMinimized: isMinimized,
                  data: buttonsData[index],
                  isSelected: buttonsData[index].routeName == routeName,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Opacity(
                opacity: .6,
                child: Tooltip(
                  message: isMinimized
                      ? 'Maximize Sidebar'
                      : 'Minimize Sidebar',
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                    ),
                    onPressed: () =>
                        context.read<SidebarProvider>().toggleSidebar(),
                    child: Container(
                      width: 5,
                      height: 50,
                      decoration: BoxDecoration(
                        color: theme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarButton extends StatefulWidget {
  final ButtonProp data;
  final bool isSelected;
  final bool isMinimized;

  const SidebarButton({
    super.key,
    required this.data,
    required this.isSelected,
    required this.isMinimized,
  });

  @override
  State<SidebarButton> createState() => _SidebarButtonState();
}

class _SidebarButtonState extends State<SidebarButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();
    final sidebar = context.read<SidebarProvider>();
    final isSelected = widget.isSelected;

    return GestureDetector(
      onTap: () => GoRouter.of(context).replaceNamed(widget.data.routeName),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Tooltip(
            message: sidebar.isMinimized ? widget.data.name : "",
            child: AnimatedContainer(
              clipBehavior: Clip.antiAlias,

              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              height: 40,
              decoration: isSelected
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.primary.withAlpha(20),

                      border: Border.all(
                        color: theme.primary,
                      ),
                    )
                  : BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _iconTextTweenBuilder(isSelected || _isHovered, theme),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconTextTweenBuilder(
    bool isSelected,
    MyThemeProvider theme,
  ) => TweenAnimationBuilder<Color?>(
    tween: ColorTween(
      begin: Colors.grey.shade200,
      end: isSelected ? theme.primary : Colors.grey.shade200,
    ),
    duration: Duration(milliseconds: 250),
    curve: Curves.easeIn,
    builder: (context, value, _) {
      return Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: widget.isMinimized
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Image.asset(
            widget.data.icon,
            color: value,
            height: 16,
            colorBlendMode: BlendMode.srcIn,
          ),
          if (!widget.isMinimized)
            Expanded(
              child: Text(
                widget.data.name,
                style: TextStyle(
                  fontSize: 13,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: value,
                ),
              ),
            ),
        ],
      );
    },
  );
}
