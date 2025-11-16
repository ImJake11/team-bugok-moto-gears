import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class PosCartTile extends StatelessWidget {
  final CartModel cartModel;

  const PosCartTile({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    final cart = cartModel;
    final theme = context.watch<MyThemeProvider>();

    Widget quantityController({
      required VoidCallback onAdd,
      required VoidCallback onRemove,
    }) {
      return Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: onRemove,
            iconSize: 22,
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: theme.primary,
            ),
            onPressed: onAdd,
            iconSize: 22,
          ),
        ],
      );
    }

    return Row(
      spacing: 20,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: theme.surfaceDim,
              border: Border.all(
                color: theme.borderColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Text(
                        referencesGetValueByID(
                          context,
                          ReferenceType.brands,
                          cart.brand,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        cartModel.model,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Spacer(),
                      Text(
                        referencesGetValueByID(
                          context,
                          ReferenceType.sizes,
                          cart.size,
                        ),
                        style: TextStyle(
                          color: theme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    referencesGetValueByID(
                      context,
                      ReferenceType.colors,
                      cart.color,
                    ),
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${currencyFormatter(cartModel.price)} (x${cartModel.quantity})",
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      quantityController(
                        onAdd: () => context.read<PosBloc>().add(
                          PosQuantityAction(
                            id: cartModel.sizeId,
                            isAdd: true,
                          ),
                        ),
                        onRemove: () => context.read<PosBloc>().add(
                          PosQuantityAction(
                            id: cartModel.sizeId,
                            isAdd: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          tooltip: "Remove Item",
          onPressed: () => context.read<PosBloc>().add(
            PosDeleteCartItem(id: cartModel.sizeId),
          ),
          icon: Icon(
            Icons.delete_rounded,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
