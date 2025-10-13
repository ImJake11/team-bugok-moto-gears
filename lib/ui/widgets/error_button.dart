import 'package:flutter/material.dart';

class CustomErrorButton extends StatefulWidget {
  final Widget child;
  final double height;
  final GestureTapCallback? ontap;

  const CustomErrorButton({
    super.key,
    required this.child,
    this.height = 50,
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
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
            border: Border.all(
              color: isHovered ? Colors.red : Colors.black,
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
