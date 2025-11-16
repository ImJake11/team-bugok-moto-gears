import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/ui/widgets/animated_text_value_change.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/responsive_font.dart';

class DashboardPageNoTransactions extends StatelessWidget {
  const DashboardPageNoTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocSelector<DashboardBloc, DashboardState, int>(
            selector: (state) {
              if (state is! DashboardInitial) return 0;
              final now = state.currentDate;
              final startOfDay = DateTime(now.year, now.month, now.day);
              final endOfDay = DateTime(
                now.year,
                now.month,
                now.day,
                23,
                59,
                59,
                999,
              );
              final todaySales = state.sales
                  .where(
                    (e) =>
                        false
                  )
                  .toList();
              return todaySales.length;
            },
            builder: (context, sales) {
              return AnimatedTextValueChange(
                duration: Duration(milliseconds: 1000),
                value: sales,
                textStyle: TextStyle(
                  fontSize: responsiveFontSize(context, 30),
                  color: context.watch<MyThemeProvider>().primary,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: Colors.black,
                      offset: Offset(3, 3),
                    ),
                    Shadow(
                      blurRadius: 5,
                      color: Colors.grey.shade800.withAlpha(120),
                      offset: Offset(-3, -3),
                    ),
                  ],
                ),
              );
            },
          ),
          Text(
            'Today',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
