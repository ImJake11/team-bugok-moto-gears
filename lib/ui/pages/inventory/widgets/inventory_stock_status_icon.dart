import 'package:flutter/material.dart';

class InventoryStatusIcon extends StatelessWidget {
  final bool isActive;
  const InventoryStatusIcon({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isActive? "Product is Active" : "Product is Inactive",
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: isActive ? Colors.green.shade900 : Colors.red.shade900,
          border: Border.all(
            color: Colors.grey.shade600,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.black,
            ),
            BoxShadow(
              offset: Offset(-1, -1),
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.grey.shade800.withAlpha(120),
            ),
          ],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
