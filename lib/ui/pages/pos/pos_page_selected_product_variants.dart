import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/widgets/product_view_size_button.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class PosPageSelectedProductVariants extends StatefulWidget {
  final ProductModel productModel;

  const PosPageSelectedProductVariants({super.key, required this.productModel});

  @override
  State<PosPageSelectedProductVariants> createState() =>
      _PosPageSelectedProductVariantsState();
}

class _PosPageSelectedProductVariantsState
    extends State<PosPageSelectedProductVariants> {
  int _selectedVariantColor = 0;

  @override
  Widget build(BuildContext context) {
    final cacheProvider = context.read<ReferencesValuesProviderCache>();
    final theme = context.watch<MyThemeProvider>();

    final colors = cacheProvider.colors;

    final ProductModel productModel = widget.productModel;

    List<VariantModel> variants = productModel.variants;

    List<VariantModel> availableVariants = variants
        .where(
          (variant) => variant.isActive == 1,
        )
        .toList();

    List<String> dropdownEntries = availableVariants.map(
      (e) {
        final query = colors.where(
          (c) => c.$1 == e.color,
        );

        if (query.isNotEmpty) {
          return query.first.$2;
        }

        return "";
      },
    ).toList();

    // find available sizes based on selected variant color
    final queryAvailableSizes = variants.where(
      (e) => e.color == _selectedVariantColor,
    );

    List<VariantSizeModel> variantSizes =
        _selectedVariantColor > 0 && queryAvailableSizes.isNotEmpty
        ? queryAvailableSizes.first.sizes
        : [];

    List<VariantSizeModel> availableSizes = variantSizes
        .where((s) => s.isActive == 1)
        .toList();

    bool hasAvailableVariants = availableVariants.isNotEmpty;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.surfaceDim,
        boxShadow: theme.shadow,
        border: Border.all(
          color: theme.borderColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                Text(
                  widget.productModel.model,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                Container(
                  width: 2,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                  referencesGetValueByID(
                    context,
                    ReferenceType.brands,
                    widget.productModel.brand,
                  ),
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                Tooltip(
                  message: "Cancel",
                  child: GestureDetector(
                    onTap: () => context.read<PosBloc>().add(
                      PosSelectProduct(productID: 0),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              currencyFormatter(widget.productModel.sellingPrice),
              style: TextStyle(
                fontSize: 18,
                color: theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              radius: BorderRadius.circular(10),
              color: Color(0xFF333333),
            ),

            if (hasAvailableVariants)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDropdown(
                    onSelected: (value) {
                      final query = colors.where((c) => c.$2 == value);

                      if (query.isEmpty) return;

                      final variantId = query.first.$1;

                      setState(() => _selectedVariantColor = variantId);
                    },
                    selectedValue: referencesGetValueByID(
                      context,
                      ReferenceType.colors,
                      _selectedVariantColor,
                    ),
                    width: 250,
                    entries: dropdownEntries,
                    label: "Select Color",
                  ),
                ],
              )
            else
              Text(
                'Product currently has no active variants available for sale',
              ),

            if (availableSizes.isNotEmpty)
              Row(
                spacing: 15,
                children: List.generate(
                  availableSizes.length,
                  (index) {
                    final sizeId = availableSizes[index].sizeValue;

                    // get the value of the size value of available sizes
                    final sizeLabel = referencesGetValueByID(
                      context,
                      ReferenceType.sizes,
                      sizeId,
                    );
                    final isInActive = availableSizes[index].isActive == 0;

                    return ProductViewSizeButton(
                      isInActive: isInActive,
                      onTap: () => context.read<PosBloc>().add(
                        PosAddProductCart(
                          cartModel: CartModel(
                            color: _selectedVariantColor,
                            size: sizeId,
                            id: availableSizes[index].id!,
                            price: widget.productModel.sellingPrice,
                            model: widget.productModel.model,
                            brand: widget.productModel.brand,
                          ),
                        ),
                      ),
                      showHoverAnimation: true,
                      label: sizeLabel,
                      isAvailable: true,
                      stock: availableSizes[index].stock,
                    );
                  },
                ),
              ),

            if (availableSizes.isEmpty && _selectedVariantColor > 0)
              Text(
                'No available sizes for this product',
              ),
          ],
        ),
      ),
    );
  }
}
