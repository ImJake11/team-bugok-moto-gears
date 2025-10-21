import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/low_stock_product_model.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class DashbardPageNoStock extends StatelessWidget {
  const DashbardPageNoStock({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ReferencesValuesProviderCache>();

    final brands = provider.brands;

    return SizedBox(
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child:
            BlocSelector<
              DashboardBloc,
              DashboardState,
              List<LowStockProductModel>
            >(
              selector: (state) {
                if (state is! DashboardInitial) return [];

                final int threshold = 3;
                final products = state.products;
                final sizes = state.sizes;

                List<LowStockProductModel> lowStockProducts = [];

                for (final product in products) {
                  final sizesRelatedToProduct = sizes.where(
                    (size) => size.productId == product.id,
                  );

                  final totalStock = sizesRelatedToProduct.fold<int>(
                    0,
                    (acc, size) => acc + size.stock,
                  );

                  if (totalStock <= threshold) {
                    lowStockProducts.add(
                      LowStockProductModel(
                        id: product.id!,
                        brand: product.brand,
                        model: product.model,
                        totalStock: totalStock,
                      ),
                    );
                  }
                }
                lowStockProducts.sort(
                  (a, b) => b.totalStock.compareTo(a.totalStock),
                );

                return lowStockProducts;
              },
              builder: (context, products) {
                if (products.isEmpty) {
                  return Center(
                    child: Text(
                      "No products.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: List.generate(
                      products.length,
                      (index) {
                        final product = products[index];

                        return Row(
                          spacing: 10,
                          children: [
                            SizedBox(
                              width: 20,
                              child: Center(
                                child: Text(
                                  product.totalStock.toString(),
                                ),
                              ),
                            ),
                            Text(
                              "${referencesGetValueByID(context, ReferenceType.brands, product.brand)} ${product.model}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                context.read<ProductFormBloc>().add(
                                  ProductFormUpdateExistingProduct(
                                    productId: product.id,
                                  ),
                                );
                                context.goNamed("new-product-form");
                              },
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade800,
                                  ),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceDim,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      color: Colors.black,
                                      offset: Offset(2, 2),
                                    ),
                                    BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      color: Colors.grey.shade900,
                                      offset: Offset(-2, -2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Restock",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: context
                                            .watch<MyThemeProvider>()
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }
}
