import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

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
          activeThumbColor: context.watch<MyThemeProvider>().primary,
          inactiveThumbColor: Colors.grey.shade700,
          onChanged: widget.onChange,
        ),
        Text(widget.isActive ? 'Active' : 'Inactive'),
      ],
    );
  }
}
