import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/widgets/product_view_color_button.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/widgets/product_view_size_button.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/utils/helpers/compute_product_stock.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class ProductViewPreview extends StatelessWidget {
  final ProductModel productModel;
  final int selectedColor;
  final void Function(int index) onTap;

  const ProductViewPreview({
    super.key,
    required this.productModel,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();
    final cacheProvider = context.read<ReferencesValuesProviderCache>();

    final brands = cacheProvider.brands;
    final colors = cacheProvider.colors;
    final sizes = cacheProvider.sizes;

    final brand = brands.where((e) => e.$1 == productModel.brand).first.$2;

    final isLowStock = computeProductStock(productModel.variants) <= 3;

    return Expanded(
      child: Center(
        child: Container(
          width: 600,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.borderColor,
            ),
            color: theme.surfaceDim,
            boxShadow: theme.shadow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
            child: Stack(
              children: [
                Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleWidget(productModel.model, "Model"),
                    _titleWidget(brand, "Brand"),
                    Divider(
                      color: Colors.grey.shade600,
                      thickness: 3,
                      radius: BorderRadius.circular(10),
                    ),

                    // list of colors available
                    Text(
                      'COLOR',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      direction: Axis.horizontal,
                      children: productModel.variants.asMap().entries.map(
                        (e) {
                          final color = colors
                              .where((c) => c.$1 == e.value.color)
                              .first
                              .$2;

                          return ProductViewColorButton(
                            onTap: () => onTap(e.key),
                            isSelected: selectedColor == e.key,
                            label: color,
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'SIZE',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      children: List.from(sizes).map(
                        (s) {
                          final (id, value) = s;

                          final variantSizes =
                              productModel.variants[selectedColor].sizes;

                          final stocks = variantSizes.where(
                            (element) => element.sizeValue == id,
                          );

                          final size = sizes.where((e) => e.$1 == id).first.$2;

                          return ProductViewSizeButton(
                            stock: stocks.isEmpty ? 0 : stocks.first.stock,
                            isAvailable: variantSizes.any(
                              (e) => e.sizeValue == id,
                            ),
                            label: size,
                          );
                        },
                      ).toList(),
                    ),
                    Spacer(),
                    Row(
                      spacing: 10,
                      children: [
                        if (productModel.isActive == 1)
                          CustomButton(
                            width: 150,
                            height: 40,
                            onTap: () {
                              context.read<PosBloc>().add(
                                PosSelectProduct(
                                  productID: productModel.id!,
                                ),
                              );
                              GoRouter.of(context).goNamed("pos");
                            },
                            borderRadius: 50,
                            child: Center(
                              child: Text("Place in Order"),
                            ),
                          ),
                        CustomButton(
                          height: 40,
                          borderRadius: 50,
                          width: 100,
                          onTap: () {
                            context.read<ProductFormBloc>().add(
                              ProductFormUpdateExistingProduct(
                                productId: productModel.id!,
                              ),
                            );
                            GoRouter.of(context).pushNamed('new-product-form');
                          },
                          child: Center(
                            child: Text("Edit"),
                          ),
                        ),
                        Spacer(),
                        Text(
                          currencyFormatter(productModel.sellingPrice),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // IN ACTIVE INDICATOR
                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (productModel.isActive == 0) _indicator("Inactive"),
                      if (isLowStock) _indicator("Low stock"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _indicator(String label) => Container(
  decoration: BoxDecoration(
    color: Colors.red.withAlpha(20),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.red,
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        color: Colors.red,
      ),
    ),
  ),
);

Widget _titleWidget(String content, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        content,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
      ),
    ],
  );
}
