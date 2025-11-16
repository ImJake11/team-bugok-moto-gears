import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/ui/widgets/animated_text_value_change.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/responsive_font.dart';

class DashboardPageTodaySales extends StatelessWidget {
  const DashboardPageTodaySales({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocSelector<DashboardBloc, DashboardState, double>(
        selector: (state) {
          if (state is DashboardInitial) {
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

            final filteredSales = state.sales.where((e) => false);

            final todaySales = filteredSales.fold<double>(
              0.00,
              (previousValue, element) => previousValue += element.total,
            );
            return todaySales;
          }

          return 0.00;
        },
        builder: (context, sales) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: AnimatedTextValueChange(
                    isCurrency: true,
                    duration: Duration(seconds: 1),
                    value: sales,
                    textStyle: TextStyle(
                      fontSize: responsiveFontSize(context, 14),
                      shadows: context.watch<MyThemeProvider>().shadow,
                      fontWeight: FontWeight.bold,
                      color: context.watch<MyThemeProvider>().primary,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
