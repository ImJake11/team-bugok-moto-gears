import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/ui/pages/pos/pos_page_selected_product_variants.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/compute_product_stock.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class PosPageTableRow extends StatefulWidget {
  final ProductModel productModel;
  final int index;

  const PosPageTableRow({
    super.key,
    required this.productModel,
    required this.index,
  });

  @override
  State<PosPageTableRow> createState() => _PosPageTableRowState();
}

class _PosPageTableRowState extends State<PosPageTableRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    final product = widget.productModel;
    final isActive = product.isActive == 1;

    if (!isActive) return const SizedBox();

    final brand = referencesGetValueByID(
      context,
      ReferenceType.brands,
      product.brand,
    );

    Widget addButton(
      bool isHovered,
      VoidCallback onAdd,
    ) => Flexible(
      child: Center(
        child: GestureDetector(
          onTap: onAdd,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isHovered ? theme.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: theme.borderColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: Text("Add"),
            ),
          ),
        ),
      ),
    );

    Widget tableCell(dynamic data) => Flexible(
      child: SizedBox(
        height: 55,
        child: Center(
          child: Text(
            "${data}",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: BlocSelector<PosBloc, PosState, int>(
        selector: (state) {
          if (state is PosProductInitialized) {
            return state.selectedProductID;
          }
          return 0;
        },
        builder: (context, selectedID) {
          if (selectedID == product.id) {
            return PosPageSelectedProductVariants(
              productModel: widget.productModel,
            );
          }

          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.index.isOdd ? Colors.black12 : theme.surfaceDim,
            ),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                tableCell(brand),
                tableCell(product.model),
                tableCell(product.variants.length),
                tableCell(computeProductStock(product.variants)),
                addButton(
                  _isHovered,
                  () => context.read<PosBloc>().add(
                    PosSelectProduct(
                      productID: product.id!,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
