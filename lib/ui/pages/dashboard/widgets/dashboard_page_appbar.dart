import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/ui/widgets/date_picker_button.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class DashboardPageAppbar extends StatelessWidget {
  const DashboardPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Hello, Welcome back!",
              style: TextStyle(
                fontSize: 14,
                color: context.watch<MyThemeProvider>().primary,
              ),
            ),
          ],
        ),
        const Spacer(),
        BlocSelector<DashboardBloc, DashboardState, DateTime>(
          selector: (state) =>
              (state is DashboardInitial) ? state.currentDate : DateTime.now(),
          builder: (context, date) => DatePickerButton(
            onPicked: (pickedDate) {
              context.read<DashboardBloc>().add(
                DashboardPickDate(referenceDate: pickedDate),
              );
            },
            pickedDate: date,
          ),
        ),
      ],
    );
  }
}
