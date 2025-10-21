import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/ui/pages/expenses/expense_pie_chart.dart';
import 'package:team_bugok_business/ui/pages/sales/widget/sales_page_table_header.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/ui/widgets/line_chart.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/utils/constants/expenses_options.dart';
import 'package:team_bugok_business/utils/database/repositories/expenses_repository.dart';
import 'package:team_bugok_business/utils/model/chart_model.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/convertDateStringToDate.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final ExpensesRepository _expensesRepository = ExpensesRepository();

  List<ExpensesModel> _expenses = [];
  int _currentYear = DateTime.now().year;
  int _selectedYear = DateTime.now().year;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  Future<void> _fetchExpenses() async {
    try {
      if (_isInitialized) {
        setState(() => _isInitialized = false);
      }

      final result = await _expensesRepository.retriveAllExpenses(
        isAnnualy: true,
        year: _selectedYear,
      );

      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _expenses = result;
        _isInitialized = true;
      });
    } catch (e, st) {
      print("Failed to fetch product ${e}");
      print(st);
      setState(() => _hasError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

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
        color: index.isOdd ? Colors.black12 : theme.surfaceDim,
      ),
      height: 50,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          cell(expenses.id),
          cell(expensesOptions[expenses.category]),
          cell(convertDateStringToDate(expenses.createdAt)),
          cell(expenses.note ?? "No Notes"),
          cell(currencyFormatter(expenses.total)),
        ],
      ),
    );

    return Builder(
      builder: (context) {
        if (!_isInitialized) {
          return Center(
            child: LoadingWidget(),
          );
        }

        if (_hasError) {
          return Center(child: Text('Something went wrong'));
        }

        // year entries of past 10 years
        List<String> entries = List.generate(
          10,
          (index) => "${_currentYear - index}",
        );

        const List<String> shortMonths = [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec",
        ];

        List<ChartModel> chartData = shortMonths.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final value = entry.value;

            // get the sales based on index
            final salesPerDay = _expenses.where(
              (element) => element.createdAt.month - 1 == index,
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

        List<String> tableHeader = ["ID", "Type", "Date", "Note", "Total"];

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 50,
          ),
          child: Column(
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Annual Expense Overview (${_currentYear})",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Track today’s expenses to shape tomorrow’s strategy",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomDropdown(
                    showDecoration: true,
                    width: 150,
                    selectedValue: _selectedYear.toString(),
                    onSelected: (value) {
                      setState(() => _selectedYear = int.parse(value!));
                      _fetchExpenses();
                    },
                    entries: entries,
                    label: "Select Year",
                  ),
                ],
              ),
              // Chart
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.surfaceDim,
                  boxShadow: theme.shadow,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 10,
                    top: 20,
                  ),
                  child: Row(
                    spacing: 30,
                    children: [
                      Expanded(
                        child: MyLineChart(
                          interval: 200000.00,
                          chartData: chartData,
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: ExpensePieChart(
                          expenses: _expenses,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                children: tableHeader
                    .map(
                      (e) => SalesPageTableHeader(
                        label: e,
                        isDarkenBg: true,
                      ),
                    )
                    .toList(),
              ),

              Expanded(
                child: _expenses.isEmpty
                    ? Center(
                        child: Text(
                          "No Expenses Record.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      )
                    : ListView(
                        children: List.generate(
                          _expenses.length,
                          (index) => tableRow(_expenses[index], index),
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
