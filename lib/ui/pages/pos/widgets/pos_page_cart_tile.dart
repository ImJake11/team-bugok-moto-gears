import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class PosCartTile extends StatefulWidget {
  final CartModel cartModel;

  const PosCartTile({super.key, required this.cartModel});

  @override
  State<PosCartTile> createState() => _PosCartTileState();
}

class _PosCartTileState extends State<PosCartTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surfaceDim,
              border: Border.all(
                color: Color(
                  0xFF555555,
                ),
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
                        widget.cartModel.brand,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.cartModel.model,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Spacer(),
                      Text(
                        widget.cartModel.size,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.cartModel.color,
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
                        "${currencyFormatter(widget.cartModel.price)} (x${widget.cartModel.quantity})",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      quantityController(
                        onAdd: () => context.read<PosBloc>().add(
                          PosQuantityAction(
                            id: widget.cartModel.id,
                            isAdd: true,
                          ),
                        ),
                        onRemove: () => context.read<PosBloc>().add(
                          PosQuantityAction(
                            id: widget.cartModel.id,
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
        GestureDetector(
          onTap: () => context.read<PosBloc>().add(
            PosDeleteCartItem(id: widget.cartModel.id),
          ),
          child: Tooltip(
            message: "Delete",
            child: Icon(
              Icons.delete,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget quantityController({
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xFF555555),
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.remove),
            onPressed: onRemove,
            iconSize: 22,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAdd,
            iconSize: 22,
          ),
        ),
      ],
    );
  }
}
