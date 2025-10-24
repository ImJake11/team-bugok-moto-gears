import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/ui/widgets/animated_text_value_change.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/responsive_font.dart';

class DashboardTotalExpenses extends StatelessWidget {
  const DashboardTotalExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DashboardBloc, DashboardState, double>(
      selector: (state) {
        if (state is! DashboardInitial) return 0.00;

        return state.expenses.fold<double>(
          0.00,
          (acc, cur) => acc + cur.total,
        );
      },
      builder: (context, expenses) {
        return Center(
          child: AnimatedTextValueChange(
            isCurrency: true,
            duration: Duration(seconds: 1),
            value: expenses,
            textStyle: TextStyle(
              fontSize: responsiveFontSize(context, 14),
              shadows: context.watch<MyThemeProvider>().shadow,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        );
      },
    );
  }
}
