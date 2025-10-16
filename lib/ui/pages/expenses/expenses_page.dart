import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/pages/sales/widget/sales_page_table_header.dart';
import 'package:team_bugok_business/ui/widgets/line_chart.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/utils/database/repositories/expenses_repository.dart';
import 'package:team_bugok_business/utils/model/chart_model.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/services/convertDateStringToDate.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  Widget cell(dynamic data) => Flexible(
    child: Center(
      child: Text("${data}"),
    ),
  );

  Widget tableRow(
    ExpensesModel expenses,
    int index,
  ) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: index.isOdd ? Colors.grey.shade900 : Colors.transparent,
    ),
    height: 50,
    child: Flex(
      direction: Axis.horizontal,
      children: [
        cell(expenses.id),
        cell(convertDateStringToDate(expenses.createdAt)),
        cell(expenses.note ?? "No Notes"),
        cell(currencyFormatter(expenses.total)),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ExpensesRepository().retriveAllExpenses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LoadingWidget());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        final expenses = snapshot.data!;

        DateTime today = DateTime.now();
        final endOfMonth = DateTime(
          today.year,
          today.month + 1,
          0,
          23,
          59,
          59,
          999,
        );

        final List<String> monthlySalesLabel = List.generate(
          endOfMonth.day,
          (index) => (index + 1).toString(),
        );

        List<ChartModel> chartData = monthlySalesLabel.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final value = entry.value;

            // get the sales based on index
            final salesPerDay = expenses.where(
              (element) => element.createdAt.day - 1 == index,
            );

            final totalSales = salesPerDay.isEmpty
                ? 0.00
                : salesPerDay.fold<double>(0.00, (acc, cur) => acc + cur.total);

            return ChartModel(
              index: index,
              label: value,
              sales: totalSales,
            );
          },
        ).toList();

        List<String> tableHeader = ["ID", "Date", "Note", "Total"];

        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            spacing: 20,
            children: [
              // Chart
              Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.surfaceDim,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(3, 3),
                      spreadRadius: 3,
                      blurRadius: 3,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade800.withAlpha(120),
                      offset: Offset(-3, -3),
                      spreadRadius: 3,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 25,
                  ),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "This Month Expenses",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: MyLineChart(
                          interval: 20000.00,
                          chartData: chartData,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                children: tableHeader
                    .map((e) => SalesPageTableHeader(label: e))
                    .toList(),
              ),

              Expanded(
                child: ListView(
                  children: List.generate(
                    expenses.length,
                    (index) => tableRow(expenses[index], index),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
