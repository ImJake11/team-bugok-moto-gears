import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashbard_page_no_stock.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_page_no_transactions.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_page_sales.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_page_today_sales.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_top_products.dart';
import 'package:team_bugok_business/ui/pages/dashboard/widgets/dashboard_page_component_wrapper.dart';
import 'package:team_bugok_business/ui/pages/dashboard/widgets/dashboard_page_appbar.dart';

import 'package:team_bugok_business/ui/pages/dashboard/dashboard_page_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      color: theme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20,
        ),
        child: Column(
          spacing: 30,
          children: [
            DashboardPageAppbar(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // deducted by 90 because  spacing is applied
                  final maxWidth = (constraints.maxWidth - 390) / 3;

                  return Row(
                    spacing: 30,
                    children: [
                      DashboardComponentWrapper(
                        title: "Today Sales",
                        height: constraints.maxHeight,
                        width: maxWidth,
                        child: DashboardPageTodaySales(),
                      ),
                      DashboardComponentWrapper(
                        height: constraints.maxHeight,
                        title: "No. Transactions",
                        width: maxWidth,
                        child: DashboardPageNoTransactions(),
                      ),
                      DashboardComponentWrapper(
                        title: "Recent Sales",
                        height: constraints.maxHeight,
                        width: maxWidth,
                        child: DashboardPageSales(),
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
              spacing: 30,
              children: [
                Expanded(child: DashboardPageChart()),
                DashboardComponentWrapper(
                  title: "This Month Top Products",
                  child: DashboardTopProducts(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
