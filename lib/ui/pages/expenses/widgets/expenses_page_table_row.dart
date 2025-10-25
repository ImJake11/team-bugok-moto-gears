import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/constants/expenses_options.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/convertDateStringToDate.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

Widget _cell(dynamic data) => Flexible(
  child: Center(
    child: Text("${data}"),
  ),
);

Widget expensesTableRow(
  ExpensesModel expenses,
  int index,
  MyThemeProvider theme,
) => Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: index.isOdd ? Colors.black12 : theme.surfaceDim,
  ),
  height: 50,
  child: Flex(
    direction: Axis.horizontal,
    children: [
      _cell(expenses.id),
      _cell(expensesOptions[expenses.category]),
      _cell(convertDateStringToDate(expenses.createdAt)),
      _cell(expenses.note ?? "No Notes"),
      _cell(currencyFormatter(expenses.total)),
    ],
  ),
);

