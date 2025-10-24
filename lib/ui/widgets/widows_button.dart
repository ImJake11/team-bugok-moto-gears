import 'package:flutter/material.dart';

class CustomWindowButton extends StatefulWidget {
  final IconData icon;
  final Color hoverColor;
  final void Function() onClicked;
  const CustomWindowButton({
    super.key,
    required this.icon,
    required this.hoverColor,
    required this.onClicked,
  });

  @override
  State<CustomWindowButton> createState() => _CustomWindowButtonState();
}

class _CustomWindowButtonState extends State<CustomWindowButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHover = true),
      onExit: (event) => setState(() => _isHover = false),
      child: GestureDetector(
        onTap: () {
          widget.onClicked();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _isHover ? widget.hoverColor : Colors.transparent,
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
