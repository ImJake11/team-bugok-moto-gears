import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/widgets/cancel_button.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/utils/databases/inventory_database.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class NewProductFormActions extends StatelessWidget {
  const NewProductFormActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 10,
      children: [
        CancelButton(),
        CustomButton(
          width: 200,
          child: Center(
            child: Text(
              "Save & Create Another",
            ),
          ),
        ),
        CustomButton(
          onTap: () {
            final state = context.read<ProductFormBloc>().state;

            if (state is ProductFormInitial) {
              final productName = state.productName;
              final category = state.category;
              final color = state.color;
              final size = state.size;
              final sellingPrice = state.sellingPrice;
              final costPrice = state.costPrice;
              final isActive = state.isActive;
              final stock = state.stock;

              if (productName == "" ||
                  category == "" ||
                  color == "" ||
                  size == "" ||
                  stock == 0) {
                return;
              }

              ProductModel data = ProductModel(
                productName: productName!,
                category: category!,
                color: color!,
                size: size!,
                stock: stock!,
                costPrice: costPrice!,
                sellingPrice: sellingPrice!,
                isActive: isActive ? 1 : 0,
                dateAdded: DateTime.now().toString(),
              );

              InventoryDB().insertProduct(data);
            }
          },
          child: Center(
            child: Text(
              "Save",
            ),
          ),
        ),
      ],
    );
  }
}
