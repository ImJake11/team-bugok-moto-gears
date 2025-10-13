import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/ui/pages/pos/pos_page_selected_product_variants.dart';
import 'package:team_bugok_business/utils/helpers/compute_product_stock.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

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
    final product = widget.productModel;

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
              color: _isHovered
                  ? Theme.of(context).colorScheme.surfaceDim
                  : widget.index.isOdd
                  ? Colors.black26
                  : Theme.of(context).colorScheme.surface,
            ),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                _tableCell(product.brand),
                _tableCell(product.model),
                _tableCell(product.variants.length),
                _tableCell(computeProductStock(product.variants)),
                _addButton(
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

  Widget _addButton(
    bool isHovered,
    VoidCallback onAdd,
  ) => Flexible(
    child: Center(
      child: GestureDetector(
        onTap: onAdd,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isHovered
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Color(0xFF555555),
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

  Widget _tableCell(dynamic data) => Flexible(
    child: SizedBox(
      height: 55,
      child: Center(
        child: Text("${data}"),
      ),
    ),
  );
}
