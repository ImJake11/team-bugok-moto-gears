import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/pages/dashboard/widgets/dashboard_page_component_wrapper.dart';
import 'package:team_bugok_business/ui/pages/dashboard/widgets/dashboard_page_appbar.dart';

import 'package:team_bugok_business/ui/pages/dashboard/dashboard_page_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
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
                        child: SizedBox(),
                      ),
                      DashboardComponentWrapper(
                        height: constraints.maxHeight,
                        title: "Transactions",
                        width: maxWidth,
                        child: SizedBox(),
                      ),
                      DashboardComponentWrapper(
                        title: "Sales",
                        height: constraints.maxHeight,
                        width: maxWidth,
                        child: SizedBox(),
                      ),
                      DashboardComponentWrapper(
                        height: constraints.maxHeight,
                        title: "On Low Stocks",
                        width: 300,
                        child: SizedBox(),
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
                  title: "Top Products",
                  child: SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
