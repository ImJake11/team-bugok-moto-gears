import 'package:flutter/material.dart';

class CustomErrorButton extends StatefulWidget {
  final Widget child;
  final double height;
  final double width;
  final Color color;
  final Color hoverColor;
  final GestureTapCallback? ontap;

  const CustomErrorButton({
    super.key,
    required this.child,
    this.height = 50,
    this.color = Colors.black,
    this.width = 100,
    this.hoverColor = Colors.red,
    this.ontap,
  });

  @override
  State<CustomErrorButton> createState() => _CustomErrorButtonState();
}

class _CustomErrorButtonState extends State<CustomErrorButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => isHovered = true),
      onExit: (event) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.ontap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.color,
            border: Border.all(
              color: isHovered ? widget.hoverColor : widget.color,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
