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
      color: theme.surfaceDim,
      width: sidebarWidth,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/carbon.png",
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            width: sidebarWidth,
            height: double.infinity,
            color: theme.surfaceDim.withAlpha(252),
          ),
          Column(
            spacing: 10,
            children: [
              SizedBox(
                height: 150,
                child: Image.asset(
                  width: sidebarWidth * .65,
                  "assets/images/moto-gears-icon-no-bg.png",
                  fit: BoxFit.cover,
                ),
              ),
              ...List.generate(
                buttonsData.length,
                (index) => GestureDetector(
                  onTap: () {
                    GoRouter.of(context).goNamed(
                      buttonsData[index].routeName,
                    );
                  },
                  child: SidebarButton(
                    data: buttonsData[index],
                    isSelected: buttonsData[index].routeName == routeName,
                  ),
                ),
              ),
            ],
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.linear,
          height: 50,
          decoration: widget.isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: _isHovered ? [0.0, 0.5, 1.0] : [0.1, 0.3, 0.6],
                    colors: [
                      theme.tertiary,
                      theme.secondary,
                      theme.primary,
                    ],
                  ),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _isHovered ? theme.surface : Colors.transparent,
                ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.data.icon,
                  color: Colors.white,
                  height: 20,
                  colorBlendMode: BlendMode.srcIn,
                ),
                Text(
                  widget.data.name,
                  style: TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonProp {
  final String name;
  final String icon;
  final String routeName;

  ButtonProp({required this.name, required this.icon, required this.routeName});
}
