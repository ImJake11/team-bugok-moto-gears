import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class StockController extends StatefulWidget {
  final int currentStock;
  final int variantIndex;
  final int sizeIndex;

  const StockController({
    super.key,
    required this.variantIndex,
    required this.sizeIndex,
    required this.currentStock,
  });

  @override
  State<StockController> createState() => _StockControllerState();
}

class _StockControllerState extends State<StockController> {
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.currentStock.toString());
  }

  void _onStockAction(bool isAdd) {
    int stock = widget.currentStock;
    int newStock = isAdd ? stock + 1 : (stock > 0 ? stock - 1 : stock);
    _controller.text = newStock.toString();

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

    return Row(
      spacing: 10,
      children: [
        GestureDetector(
          onTap: () {
            _onStockAction(false);
          },
          child: Icon(
            Icons.horizontal_rule_rounded,
            size: iconSize,
          ),
        ),
        SizedBox(
          height: 40,
          width: 100,
          child: CustomTextfield(
            textAlign: TextAlign.center,
            maxLength: 3,
            fillColor: context.watch<MyThemeProvider>().surfaceDim,
            showShadow: false,
            textEditingController: _controller,
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
        GestureDetector(
          onTap: () {
            _onStockAction(true);
          },
          child: Icon(
            Icons.add_rounded,
            size: iconSize,
          ),
        ),
      ],
    );
  }
}
