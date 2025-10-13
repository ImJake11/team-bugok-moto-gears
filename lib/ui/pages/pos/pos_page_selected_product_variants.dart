import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/widgets/product_view_size_button.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';
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
  String _selectedVariantColor = "";

  @override
  Widget build(BuildContext context) {
    final dropdownEntries = widget.productModel.variants
        .map((e) => e.color)
        .toList();

    final i = dropdownEntries.indexOf(_selectedVariantColor);

    final List<VariantSizeModel> availableSizes =
        _selectedVariantColor.isNotEmpty
        ? widget.productModel.variants[i].sizes
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
                  widget.productModel.brand.toUpperCase(),
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
                  onSelected: (value) =>
                      setState(() => _selectedVariantColor = value!),
                  selectedValue: i <= 0 ? null : dropdownEntries.elementAt(i),
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
                  (index) => ProductViewSizeButton(
                    onTap: () => context.read<PosBloc>().add(
                      PosAddProductCart(
                        cartModel: CartModel(
                          color: _selectedVariantColor,
                          size: availableSizes[index].sizeValue,
                          id: availableSizes[index].id!,
                          price: widget.productModel.sellingPrice,
                          model: widget.productModel.model,
                          brand: widget.productModel.brand,
                        ),
                      ),
                    ),
                    showHoverAnimation: true,
                    label: availableSizes[index].sizeValue,
                    isAvailable: true,
                    stock: availableSizes[index].stock,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
