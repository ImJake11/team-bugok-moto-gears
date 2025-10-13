import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/ui/pages/pos/widgets/pos_page_cart_tile.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/utils/helpers/compute_cart_total.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class PosPageCart extends StatelessWidget {
  const PosPageCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceDim,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Cart',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Expanded(
              child: BlocSelector<PosBloc, PosState, List<CartModel>>(
                selector: (state) {
                  if (state is PosProductInitialized) {
                    return state.cart;
                  }
                  return [];
                },
                builder: (context, cart) {
                  if (cart.isEmpty) {
                    return Center(
                      child: Text('No Items'),
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      children: List.generate(
                        cart.length,
                        (index) => BlocSelector<PosBloc, PosState, int>(
                          selector: (state) {
                            if (state is PosProductInitialized &&
                                state.cart.isNotEmpty) {
                              return state.cart[index].quantity;
                            }
                            return 0;
                          },
                          builder: (context, quantity) {
                            return PosCartTile(
                              cartModel: cart[index],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                child: BlocSelector<PosBloc, PosState, List<CartModel>>(
                  selector: (state) {
                    if (state is! PosProductInitialized) return [];

                    return state.cart;
                  },
                  builder: (context, cart) {
                    return Column(
                      spacing: 20,
                      children: [
                        ...List.generate(
                          cart.length,
                          (index) {
                            CartModel data = cart[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${currencyFormatter(data.price)} (x${data.quantity})",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  currencyFormatter(data.quantity * data.price),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              computeCartTotal(context),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),

                        LayoutBuilder(
                          builder: (context, constraints) => CustomButton(
                            onTap: () =>
                                context.read<PosBloc>().add(PosCheckOutItems()),
                            width: constraints.maxWidth,
                            child: Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  width: 20,
                                  color: Colors.white,
                                  colorBlendMode: BlendMode.srcIn,
                                  "assets/images/shopping-cart.png",
                                ),
                                Text('Check Out'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
