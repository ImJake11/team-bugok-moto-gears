import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';

class StockController extends StatefulWidget {
  final TextEditingController stockController;
  final int variantIndex;
  final int sizeIndex;

  const StockController({
    super.key,
    required this.stockController,
    required this.variantIndex,
    required this.sizeIndex,
  });

  @override
  State<StockController> createState() => _StockControllerState();
}

class _StockControllerState extends State<StockController> {
  void _onStockAction(bool isAdd) {
    int stock = int.tryParse(widget.stockController.text) ?? 0;
    int newStock = isAdd ? stock + 1 : (stock > 0 ? stock - 1 : stock);

    widget.stockController.text = newStock.toString();

    context.read<ProductFormBloc>().add(
      ProductFormUpdateSize(
        variantIndex: widget.variantIndex,
        sizeIndex: widget.sizeIndex,
        stock: newStock,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 30;

    return Stack(
      children: [
        SizedBox(
          height: 50,
          child: CustomTextfield(
            maxLength: 3,
            fillColor: Theme.of(context).colorScheme.surface,
            showShadow: false,
            textEditingController: widget.stockController,
            width: 200,
            onChange: (value) => context.read<ProductFormBloc>().add(
              ProductFormUpdateSize(
                variantIndex: widget.variantIndex,
                sizeIndex: widget.sizeIndex,
                stock: int.tryParse(value),
              ),
            ),
            placeholder: "Stock",
            formatter: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        Positioned(
          right: 5,
          top: 2,
          child: GestureDetector(
            onTap: () {
              _onStockAction(true);
            },
            child: Icon(
              Icons.arrow_drop_up,
              size: iconSize,
            ),
          ),
        ),
        Positioned(
          right: 5,
          bottom: 2,
          child: GestureDetector(
            onTap: () {
              _onStockAction(false);
            },
            child: Icon(
              Icons.arrow_drop_down,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
