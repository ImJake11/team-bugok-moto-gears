import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/widgets/product_view_related_button.dart';
import 'package:team_bugok_business/ui/widgets/custom_button.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class ProductViewRelatedBrands extends StatefulWidget {
  final int currentBrand;
  final int currentProductId;
  final Function(ProductModel) onTap;

  const ProductViewRelatedBrands({
    super.key,
    required this.currentBrand,
    required this.currentProductId,
    required this.onTap,
  });

  @override
  State<ProductViewRelatedBrands> createState() =>
      _ProductViewRelatedBrandsState();
}

class _ProductViewRelatedBrandsState extends State<ProductViewRelatedBrands> {
  late List<ProductModel> _products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRelatedProducts();
  }

  @override
  void didUpdateWidget(covariant ProductViewRelatedBrands oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentProductId != widget.currentProductId) {
      _getRelatedProducts();
    }
  }

  void _getRelatedProducts() {
    final s = context.read<InventoryBloc>().state as InventoryInitial;

    _products = s.products
        .where(
          (element) => widget.currentProductId != element.id,
        )
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          Text(
            "Related Product",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: _products.isEmpty
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 15,
                      children: [
                        Text(
                          'No related product found',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        CustomButton(
                          onTap: () {
                            GoRouter.of(context).goNamed('inventory');
                          },
                          child: Center(
                            child: Text(
                              "Go to inventory",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      spacing: 15,
                      children: _products
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                widget.onTap(e);
                              },
                              child: ProductViewRelatedButton(
                                brand: referencesGetValueByID(
                                  context,
                                  ReferenceType.brands,
                                  widget.currentBrand,
                                ),
                                model: e.model,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
