import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/widgets/product_view_color_button.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/widgets/product_view_size_button.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class ProductViewPreview extends StatefulWidget {
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
  State<ProductViewPreview> createState() => _ProductViewPreviewState();
}

class _ProductViewPreviewState extends State<ProductViewPreview> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          width: 600,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF555555),
            ),
            color: Theme.of(context).colorScheme.surfaceDim,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 3,
                spreadRadius: 5,
                offset: Offset(3, 3),
              ),
              BoxShadow(
                color: Colors.grey.shade800.withAlpha(120),
                blurRadius: 3,
                spreadRadius: 3,
                offset: Offset(-3, -3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleWidget(widget.productModel.model, "Model"),
                _titleWidget(widget.productModel.brand, "Brand"),
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
                  children: widget.productModel.variants.asMap().entries.map(
                    (e) {
                      return ProductViewColorButton(
                        onTap: () => widget.onTap(e.key),
                        isSelected: widget.selectedColor == e.key,
                        label: e.value.color,
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
                  children:
                      List.from([
                        "S",
                        "M",
                        "L",
                        "XL",
                        "XXL",
                      ]).map(
                        (s) {
                          final sizes = widget
                              .productModel
                              .variants[widget.selectedColor]
                              .sizes;

                          final stocks = sizes.where(
                            (element) => element.sizeValue == s,
                          );

                          return ProductViewSizeButton(
                            stock: stocks.isEmpty ? 0 : stocks.first.stock,
                            isAvailable: sizes.any(
                              (element) => element.sizeValue == s,
                            ),
                            label: s,
                          );
                        },
                      ).toList(),
                ),
                Spacer(),
                Row(
                  spacing: 10,
                  children: [
                    CustomButton(
                      width: 150,
                      height: 40,
                      onTap: () {},
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
                            productModel: widget.productModel,
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
                      currencyFormatter(widget.productModel.sellingPrice),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
