import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  final bool isActive;
  final Function(bool)? onChange;

  const CustomToggleSwitch({
    super.key,
    required this.isActive,
    this.onChange,
  });

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Switch(
          value: widget.isActive,
          activeThumbColor: Theme.of(context).colorScheme.primary,
          inactiveThumbColor: Colors.grey.shade700,
          onChanged: widget.onChange,
        ),
        Text(widget.isActive ? 'Active' : 'Inactive'),
      ],
    );
  }
}
