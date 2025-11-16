import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/ui/widgets/animated_text_value_change.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/top_products_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class DashboardTopProducts extends StatelessWidget {
  const DashboardTopProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child:
            BlocSelector<
              DashboardBloc,
              DashboardState,
              (List<TopProductsMdodel>, int)
            >(
              selector: (state) {
                if (state is! DashboardInitial) return ([], 0);

                final sales = state.sales;

                List<TopProductsMdodel> topProducts = [];

                // loop sales
                for (final sale in sales) {
                  final items = sale.items;

                  // loop items each sales
                  for (final item in items) {
                    int index = topProducts.indexWhere(
                      (tp) => tp.model == item.model,
                    );

                    //if index is -1 means current items is not existing in the list
                    final isExisting = index != -1;
                    isExisting
                        ? topProducts[index] = topProducts[index].copyWith(
                            sales: topProducts[index].sales + item.quantity,
                          )
                        : topProducts.add(
                            TopProductsMdodel(
                              id: item.sizeId,
                              brand: item.brand,
                              model: item.model,
                              sales: item.quantity,
                            ),
                          );
                  }
                }

                topProducts.sort((a, b) => b.sales.compareTo(a.sales));

                final totalSales = topProducts.fold<int>(
                  0,
                  (acc, product) => acc + product.sales,
                );

                return (topProducts, totalSales);
              },
              builder: (context, result) {
                final (products, totalSales) = result;

                if (products.isEmpty) {
                  return Center(
                    child: Text(
                      "No Products.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    spacing: 15,
                    children: List.generate(
                      products.length,
                      (index) => _WidgetTile(
                        products[index],
                        totalSales,
                      ),
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }
}

class _WidgetTile extends StatelessWidget {
  final TopProductsMdodel product;
  final int totalSales;

  const _WidgetTile(this.product, this.totalSales);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    final percentageValue = (product.sales / totalSales) * 100;
    final brand = referencesGetValueByID(
      context,
      ReferenceType.brands,
      product.brand,
    );

    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: Row(
            spacing: 5,
            children: [
              Text(
                brand,
                style: TextStyle(
                  overflow: TextOverflow.fade,
                  fontSize: 12,
                ),
              ),
              Text(
                product.model,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  overflow: TextOverflow.fade,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        AnimatedTextValueChange(
          value: percentageValue,
          textStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
          ),
          duration: const Duration(seconds: 2),
        ),
        TweenAnimationBuilder(
          curve: Curves.linear,
          tween: Tween<double>(
            begin: 0,
            end: product.sales.toDouble(),
          ),
          duration: Duration(seconds: 2),
          builder: (context, value, _) {
            return Container(
              width: 70,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: theme.shadow,
              ),
              child: LinearProgressIndicator(
                color: theme.primary,
                backgroundColor: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10),
                value: value / totalSales,
              ),
            );
          },
        ),
      ],
    );
  }
}
