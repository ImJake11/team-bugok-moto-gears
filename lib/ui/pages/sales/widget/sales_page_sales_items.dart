import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/ui/pages/sales/widget/sales_page_table_header.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class SalesPageSalesItems extends StatelessWidget {
  final List<CartModel> items;

  const SalesPageSalesItems({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Column(
            spacing: 15,
            children: [
              Text(
                'TRANSACTION ITEMS',
                style: TextStyle(
                  color: theme.primary,
                  fontSize: 20,
                ),
              ),

              Flex(
                direction: Axis.horizontal,
                children: [
                  SalesPageTableHeader(
                    label: "BRAND",
                    isDarkenBg: false,
                  ),
                  SalesPageTableHeader(
                    label: "MODEL",
                    isDarkenBg: false,
                  ),
                  SalesPageTableHeader(
                    label: "COLOR",
                    isDarkenBg: false,
                  ),
                  SalesPageTableHeader(
                    label: "SIZE",
                    isDarkenBg: false,
                  ),
                  SalesPageTableHeader(
                    label: "QTY",
                    isDarkenBg: false,
                  ),
                  SalesPageTableHeader(
                    label: "PRICE",
                    isDarkenBg: false,
                  ),
                ],
              ),

              ...List.generate(
                items.length,
                (index) {
                  final item = items[index];

                  return Flex(
                    direction: Axis.horizontal,
                    children: [
                      _cell(item.brand),
                      _cell(item.model),
                      _cell(item.color),
                      _cell(item.size),
                      _cell(item.quantity),
                      _cell(currencyFormatter(item.price)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _cell(dynamic content) => Flexible(
  child: Center(
    child: Text("${content}"),
  ),
);
