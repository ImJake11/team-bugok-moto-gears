import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:team_bugok_business/ui/widgets/custom_date_picker.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class DatePickerButton extends StatefulWidget {
  final DateTime pickedDate;
  final void Function(DateTime pickedDate) onPicked;

  const DatePickerButton({
    super.key,
    required this.pickedDate,
    required this.onPicked,
  });

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  void _pickDate() {
    CustomDatePicker(
      initialDate: widget.pickedDate,
      context: context,
      onDateSelected: (value) {
        widget.onPicked(value!);
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    final formattedDate = DateFormat("MMMM dd, yyyy").format(widget.pickedDate);

    return GestureDetector(
      onTap: () {
        _pickDate();
      },
      child: Container(
        height: 49,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.surfaceDim,
          border: Border.all(
            color: theme.borderColor,
          ),
          boxShadow: theme.shadow,
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Image.asset(
                "assets/images/calendar.png",
                width: 18,
                colorBlendMode: BlendMode.srcIn,
                color: theme.primary,
              ),
              Text(formattedDate),
            ],
          ),
        ),
      ),
    );
  }
}
