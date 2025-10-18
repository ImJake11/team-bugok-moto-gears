import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/widgets/product_view_size_button.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';
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
  int _selectedVariantId = 0;

  @override
  Widget build(BuildContext context) {
    final cacheProvider = context.read<ReferencesValuesProviderCache>();

    final colors = cacheProvider.colors;
    final brands = cacheProvider.brands;
    final sizes = cacheProvider.sizes;

    final ProductModel productModel = widget.productModel;

    List<VariantModel> variants = productModel.variants;

    List<String> dropdownEntries = variants.map(
      (e) {
        final query = colors.where((c) => c.$1 == e.color);

        if (query.isNotEmpty) {
          return query.first.$2;
        }

        return "";
      },
    ).toList();

    // find available sizes based on selected variant color
    final queryAvailableSizes = variants.where(
      (e) => e.color == _selectedVariantId,
    );

    List<VariantSizeModel> availableSizes =
        _selectedVariantId > 0 && queryAvailableSizes.isNotEmpty
        ? queryAvailableSizes.first.sizes
        : [];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceDim,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 3,
            color: Colors.grey.shade800.withAlpha(120),
            offset: Offset(-3, -3),
          ),
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 3,
            color: Colors.black,
            offset: Offset(3, 3),
          ),
        ],
        border: Border.all(color: Color(0xFF555555)),
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
                  referencesGetValueByID(brands, widget.productModel.brand),
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
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              radius: BorderRadius.circular(10),
              color: Color(0xFF333333),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropdown(
                  onSelected: (value) {
                    final query = colors.where((c) => c.$2 == value);

                    if (query.isEmpty) return;

                    final variantId = query.first.$1;

                    setState(() => _selectedVariantId = variantId);
                  },
                  selectedValue: referencesGetValueByID(
                    colors,
                    _selectedVariantId,
                  ),
                  width: 250,
                  entries: dropdownEntries,
                  label: "Select Color",
                ),
              ],
            ),

            if (availableSizes.isNotEmpty)
              Row(
                spacing: 15,
                children: List.generate(
                  availableSizes.length,
                  (index) {
                    final sizeId = availableSizes[index].id;
                    final sizeValue = availableSizes[index].sizeValue;

                    // get the value of the size value of available sizes
                    final querySize = sizes.where((s) => s.$1 == sizeValue);

                    final sizeLabel = querySize.isEmpty
                        ? ""
                        : querySize.first.$2;

                    return ProductViewSizeButton(
                      onTap: () => context.read<PosBloc>().add(
                        PosAddProductCart(
                          cartModel: CartModel(
                            color: _selectedVariantId,
                            size: sizeId!,
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
          ],
        ),
      ),
    );
  }
}
