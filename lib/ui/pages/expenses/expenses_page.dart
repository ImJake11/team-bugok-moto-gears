import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/ui/pages/expenses/widgets/expenses_page_line_chart.dart';
import 'package:team_bugok_business/ui/pages/expenses/widgets/expenses_page_pie_chart.dart';
import 'package:team_bugok_business/ui/pages/expenses/widgets/expenses_page_table_row.dart';
import 'package:team_bugok_business/ui/pages/sales/widget/sales_page_table_header.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/ui/widgets/padding_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/utils/database/repositories/expenses_repository.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

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
  bool _isChartVisible = true;

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

      if (!mounted) return;

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

        List<String> tableHeader = ["ID", "Type", "Date", "Note", "Total"];

        var appBar = Row(
          spacing: 10,
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
            CustomButton(
              onTap: () => setState(() => _isChartVisible = !_isChartVisible),
              showShadow: false,
              child: Center(
                child: Text(_isChartVisible ? "Hide Charts" : "Show Charts"),
              ),
            ),
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
        );

        return PaddingWrapper(
          child: Column(
            spacing: 20,
            children: [
              appBar,
              if (_isChartVisible)
                Row(
                  spacing: 20,
                  children: [
                    expensesPageLineChart(_expenses, theme),
                    expensesPagePieChart(_expenses, theme),
                  ],
                ),

              // Chart
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
                          (index) => expensesTableRow(
                            _expenses[index],
                            index,
                            theme,
                          ),
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
