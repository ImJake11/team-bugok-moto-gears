import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final routeName = GoRouter.of(context).state.name;
    final theme = context.watch<MyThemeProvider>();

    final double sidebarWidth = 270;

    List<ButtonProp> buttonsData = [
      ButtonProp(
        routeName: "dashboard",
        name: "Dashboard",
        icon: "assets/images/dashboard.png",
      ),
      ButtonProp(
        routeName: "inventory",
        name: "Inventory Management",
        icon: "assets/images/box.png",
      ),
      ButtonProp(
        routeName: "pos",
        name: "New Sale",
        icon: "assets/images/pos-terminal.png",
      ),
      ButtonProp(
        name: "Small Expense",
        icon: "assets/images/shopping-bag.png",
        routeName: "small-purchase",
      ),
      ButtonProp(
        name: "Sales History",
        icon: "assets/images/sales.png",
        routeName: 'sales',
      ),
      ButtonProp(
        name: "Expense Summary",
        icon: "assets/images/expenses.png",
        routeName: 'expenses',
      ),
      ButtonProp(
        name: "Store Setup",
        icon: "assets/images/settings.png",
        routeName: 'settings',
      ),
    ];

    return Container(
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
      child: Column(
        spacing: 10,
        children: [
          SizedBox(
            height: 100,
            child: Image.asset(
              width: sidebarWidth * .65,
              "assets/images/moto-gears-icon-no-bg.png",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(
            buttonsData.length,
            (index) => SidebarButton(
              data: buttonsData[index],
              isSelected: buttonsData[index].routeName == routeName,
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

  const SidebarButton({
    super.key,
    required this.data,
    required this.isSelected,
  });

  @override
  State<SidebarButton> createState() => _SidebarButtonState();
}

class _SidebarButtonState extends State<SidebarButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();
    final isSelected = widget.isSelected;

    return GestureDetector(
      onTap: () => GoRouter.of(context).goNamed(widget.data.routeName),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
            height: 50,
            decoration: isSelected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.primary.withAlpha(30),
                    border: Border.all(
                      color: theme.primary,
                    ),
                  )
                : null,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: _iconTextTweenBuilder(isSelected || _isHovered, theme),
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
        children: [
          Image.asset(
            widget.data.icon,
            color: value,
            height: 20,
            colorBlendMode: BlendMode.srcIn,
          ),
          Text(
            widget.data.name,
            style: TextStyle(
              fontSize: 14,
              overflow: TextOverflow.fade,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: value,
            ),
          ),
        ],
      );
    },
  );
}

class ButtonProp {
  final String name;
  final String icon;
  final String routeName;

  ButtonProp({required this.name, required this.icon, required this.routeName});
}
