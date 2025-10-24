import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashbard_page_no_stock.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_page_chart.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_page_no_transactions.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_page_today_sales.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_top_products.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_total_expenses.dart';
import 'package:team_bugok_business/ui/pages/dashboard/widgets/dashboard_page_appbar.dart';
import 'package:team_bugok_business/ui/pages/dashboard/widgets/dashboard_page_component_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/padding_wrapper.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: Column(
        spacing: 20,
        children: [
          DashboardPageAppbar(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // deducted by 90 because  spacing is applied
                final maxWidth = (constraints.maxWidth - 360) / 3;

                return Row(
                  spacing: 20,
                  children: [
                    DashboardComponentWrapper(
                      title: "Today's Sales",
                      height: constraints.maxHeight,
                      width: maxWidth,
                      child: DashboardPageTodaySales(),
                    ),
                    DashboardComponentWrapper(
                      title: "This Month Expenses",
                      height: constraints.maxHeight,
                      width: maxWidth,
                      child: DashboardTotalExpenses(),
                    ),
                    DashboardComponentWrapper(
                      height: constraints.maxHeight,
                      title: "No. Transactions",
                      width: maxWidth,
                      child: DashboardPageNoTransactions(),
                    ),

                    DashboardComponentWrapper(
                      height: constraints.maxHeight,
                      title: "On Low Stocks",
                      width: 300,
                      child: DashbardPageNoStock(),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            spacing: 20,
            children: [
              Expanded(child: DashboardPageChart()),
              DashboardComponentWrapper(
                height: 380,
                title: "This Month Top Products",
                child: DashboardTopProducts(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
