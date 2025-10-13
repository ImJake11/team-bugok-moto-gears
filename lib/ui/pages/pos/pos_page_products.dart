import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/ui/pages/pos/widgets/pos_page_table_row.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';

class PosPageProducts extends StatefulWidget {
  const PosPageProducts({super.key});

  @override
  State<PosPageProducts> createState() => _PosPageProductsState();
}

class _PosPageProductsState extends State<PosPageProducts> {
  Widget tableHeader(String label) {
    return Flexible(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceDim,
        ),
        child: Center(
          child: Text(label),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 20,
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              tableHeader("Brand"),
              tableHeader("Model"),
              tableHeader("Variants"),
              tableHeader("Stock"),
              tableHeader("Action"),
            ],
          ),

          Expanded(
            child: BlocBuilder<PosBloc, PosState>(
              builder: (context, state) {
                if (state is PosProductInitialized) {
                  final query = state.query;
                  final searchResults = state.searchResults;
                  final products = state.products;
                  final isSelectedProduct = state.selectedProductID != 0;

                  final displayList = query.isEmpty ? products : searchResults;

                  if (state.products.isEmpty) {
                    return Center(
                      child: Text('No products found'),
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      spacing: isSelectedProduct ? 20 : 10,
                      children: List.generate(
                        displayList.length,
                        (index) => PosPageTableRow(
                          index: index,
                          productModel: displayList[index],
                        ),
                      ),
                    ),
                  );
                }

                return Center(
                  child: LoadingWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceOrderButton extends StatefulWidget {
  const _PlaceOrderButton({
    super.key,
  });

  @override
  State<_PlaceOrderButton> createState() => __PlaceOrderButtonState();
}

class __PlaceOrderButtonState extends State<_PlaceOrderButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Center(
        child: MouseRegion(
          onEnter: (event) => setState(() => _isHovered = true),
          onExit: (event) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _isHovered
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Text("Order"),
            ),
          ),
        ),
      ),
    );
  }
}
