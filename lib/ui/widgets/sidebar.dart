import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final double sidebarWidth = 300;

    List<ButtonProp> buttonsData = [
      ButtonProp(name: "Overview", icon: "assets/images/dashboard.png"),
      ButtonProp(name: "Inventory", icon: "assets/images/box.png"),
      ButtonProp(name: "Sales History", icon: "assets/images/sales.png"),
      ButtonProp(name: "Expenses", icon: "assets/images/expenses.png"),
    ];

    return Container(
      color: Colors.black,
      width: sidebarWidth,
      height: MediaQuery.of(context).size.height,
      child: Column(
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
            (index) =>
                SidebarButton(data: buttonsData[index], isSelected: index == 1),
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
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeIn,
          height: 60,
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
                    colors: [theme.tertiary, theme.secondary, theme.primary],
                  ),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _isHovered ? theme.surface : Colors.black,
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
                Text(widget.data.name, style: TextStyle(fontSize: 15)),
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

  ButtonProp({required this.name, required this.icon});
}
