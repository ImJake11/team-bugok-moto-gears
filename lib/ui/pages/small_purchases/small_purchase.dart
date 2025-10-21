import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/ui/widgets/snackbar.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/constants/expenses_options.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/database/repositories/expenses_repository.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class SmallPurchase extends StatefulWidget {
  const SmallPurchase({super.key});

  @override
  State<SmallPurchase> createState() => _SmallPurchaseState();
}

class _SmallPurchaseState extends State<SmallPurchase> {
  final ExpensesRepository _expensesRepository = ExpensesRepository();

  final _noteController = TextEditingController();
  final _costController = TextEditingController();

  int _selectedExpenses = -1;

  Future<void> _saveExpenses() async {
    try {
      if (_costController.text.isEmpty || _selectedExpenses < 0) return;
      context.read<LoadingProvider>().showLoading("Saving Data");

      final newExpense = ExpensesCompanion.insert(
        category: Value(_selectedExpenses),
        relatedId: 0,
        total: double.tryParse(_costController.text) ?? 0.00,
        note: Value(_noteController.text),
      );

      await _expensesRepository.insertExpenses(newExpense);
      context.read<DashboardBloc>().add(DashboardLoadData());
      await Future.delayed(Duration(seconds: 1));

      context.read<LoadingProvider>().closeLoading();
      CustomSnackBar(
        context: context,
        message: "Expense record saved successfully",
      ).show();
      _costController.text = "";
      _noteController.text = "";
    } catch (e, st) {
      context.read<LoadingProvider>().closeLoading();
      CustomSnackBar(
        context: context,
        message: "Failed to save expense",
      ).show();
      print("Failed to save small expenses ${e}");
      print(st);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return Center(
      child: Container(
        width: 500,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.surfaceDim,
          border: Border.all(
            color: theme.borderColor,
          ),
          boxShadow: theme.shadow,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 20,
            children: [
              Text(
                "Small Expense",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              CustomDropdown(
                entries: expensesOptions,
                label: 'Type of expense',
                onSelected: (value) {
                  final index = expensesOptions.indexOf(value!);

                  setState(() => _selectedExpenses = index);
                },
              ),

              CustomTextfield(
                maxLines: 5,
                height: 100,
                textEditingController: _noteController,
                maxLength: 200,
                fillColor: theme.surfaceDim,
                placeholder: "Note (Optional)",
                showShadow: false,
              ),
              CustomTextfield(
                textEditingController: _costController,
                fillColor: theme.surfaceDim,
                maxLength: 10,
                placeholder: "Cost",
                showShadow: false,
                formatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    onTap: () => _saveExpenses(),
                    showShadow: false,
                    child: Center(
                      child: Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
