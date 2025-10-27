import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/widgets/inventory_stock_status_icon.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/compute_product_stock.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class InventoryRow extends StatefulWidget {
  final ProductModel productModel;
  final int index;

  const InventoryRow({
    super.key,
    required this.productModel,
    required this.index,
  });

  @override
  State<InventoryRow> createState() => _InventoryRowState();
}

class _InventoryRowState extends State<InventoryRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    final product = widget.productModel;

    final id = product.id;
    final brand = referencesGetValueByID(
      context,
      ReferenceType.brands,
      product.brand,
    );
    final model = product.model;
    final category = referencesGetValueByID(
      context,
      ReferenceType.categories,
      product.category,
    );
    final costPrice = currencyFormatter(product.costPrice);
    final sellingPrice = currencyFormatter(product.sellingPrice);
    final variants = product.variants.length;
    final stock = computeProductStock(product.variants);

    final isLow = stock <= 3;
    final isActive = product.isActive == 1;

    Widget tableCell(
      int flex,
      dynamic content,
    ) {
      return Flexible(
        flex: flex,
        child: Center(
          child: Text(
            "${content}",
            style: TextStyle(
              fontSize: 12,
              color: isLow ? Colors.red : Colors.white,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => context.goNamed(
        "product-view",
        extra: product,
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: _isHovered
                  ? theme.primary
                  : isLow
                  ? Colors.red.shade900
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10),
            color: widget.index.isEven ? Colors.black12 : theme.surfaceDim,
          ),
          width: double.infinity,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              tableCell(2, brand),
              tableCell(2, model),
              tableCell(2, category),
              tableCell(2, sellingPrice),
              tableCell(2, costPrice),
              tableCell(2, variants),
              tableCell(1, stock),
              Flexible(
                flex: 1,
                child: Center(
                  child: InventoryStatusIcon(
                    isActive: isActive,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      context.read<ProductFormBloc>().add(
                        ProductFormUpdateExistingProduct(
                          productId: widget.productModel.id!,
                        ),
                      );
                      GoRouter.of(context).goNamed(
                        'new-product-form',
                        extra: widget.productModel,
                      );
                    },
                    icon: Icon(
                      Icons.edit_rounded,
                      color: context.read<MyThemeProvider>().primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
