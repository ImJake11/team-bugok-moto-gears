import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:team_bugok_business/ui/pages/sales/widget/sales_page_table_header.dart';
import 'package:team_bugok_business/utils/constants/expenses_options.dart';
import 'package:team_bugok_business/utils/database/repositories/expenses_repository.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/convertDateStringToDate.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

Widget _cell(dynamic data) => Flexible(
  child: Center(
    child: Text("${data}"),
  ),
);

Widget _showBtn(
  void Function() onPressed,
  bool isShowed,
) => Flexible(
  child: Center(
    child: TextButton(
      onPressed: onPressed,
      child: Text(isShowed ? "" : 'Show Items'),
    ),
  ),
);

Widget _itemsCard(BuildContext context, List<ExpenseItemModel> items) {
  final theme = context.watch<MyThemeProvider>();

  final labels = [
    'Product',
    'Variant',
    'Size',
    'Quantity',
    'Price',
    'Sub Total',
  ];

  return items.isEmpty
      ? Text("No items found")
      : Align(
          alignment: Alignment.centerRight,
          child: Column(
            spacing: 10,
            children: [
              Text(
                'ITEMS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.primary,
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                children: labels
                    .map(
                      (e) => SalesPageTableHeader(label: e),
                    )
                    .toList(),
              ),
              ...List.generate(
                items.length,
                (index) {
                  final item = items[index];

                  final brand = referencesGetValueByID(
                    context,
                    ReferenceType.brands,
                    item.brand,
                  );
                  final model = item.model;
                  final color = referencesGetValueByID(
                    context,
                    ReferenceType.colors,
                    item.color,
                  );
                  final size = referencesGetValueByID(
                    context,
                    ReferenceType.sizes,
                    item.size,
                  );
                  final price = currencyFormatter(item.price);
                  final qty = item.quantity;

                  final cleanPrice = price.replaceAll(RegExp(r'[^0-9.]'), '');
                  final computeSubtotal = double.parse(cleanPrice) * qty;
                  final subtotal = currencyFormatter(computeSubtotal);

                  return Opacity(
                    opacity: .6,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        _cell("$brand $model"),
                        _cell(color),
                        _cell(size),
                        _cell("(x$qty)"),
                        _cell(price),
                        _cell(subtotal),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
}

Widget expensesTableRow(
  ExpensesModel expenses,
  int index,
  MyThemeProvider theme,
) {
  bool isShowed = false;
  bool hasError = false;
  bool isLoading = false;
  List<ExpenseItemModel> items = [];

  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      Future<void> getItems() async {
        try {
          final ExpensesRepository expensesRepository = ExpensesRepository();

          final result = await expensesRepository.retriveExpensesItem(
            expenses.id!,
          );

          setState(() => items = result);
        } catch (e) {
          setState(() => hasError = true);
        } finally {
          await Future.delayed(Duration(seconds: 1));
          setState(() => isLoading = false);
        }
      }

      void setInitialActions() {
        setState(() {
          hasError = false;
          isLoading = true;
          isShowed = true;
        });
        getItems();
      }

      return MouseRegion(
        onExit: (_) => setState(() => isShowed = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isShowed
                ? Colors.black
                : index.isOdd
                ? Colors.black12
                : theme.surfaceDim,
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isShowed ? 20 : 10,
            ),
            child: Column(
              spacing: 20,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    _cell(expenses.id),
                    _cell(expensesOptions[expenses.category]),
                    _cell(expenses.createdAt),
                    _cell(
                      (expenses.note?.isNotEmpty ?? false)
                          ? expenses.note
                          : "No note",
                    ),
                    _cell(currencyFormatter(expenses.total)),
                    _showBtn(setInitialActions, isShowed),
                  ],
                ),
                if (isShowed)
                  Builder(
                    builder: (context) {
                      if (hasError) {
                        return Text(
                          "Failed to get items",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        );
                      } else if (isLoading) {
                        return SpinKitFadingCircle(
                          color: theme.primary,
                          size: 30,
                        );
                      } else {
                        return _itemsCard(context, items);
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
