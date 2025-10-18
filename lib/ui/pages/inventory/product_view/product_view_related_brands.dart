import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/widgets/product_view_related_button.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';

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
  late Future<List<ProductModel>> _products;

  @override
  void didUpdateWidget(covariant ProductViewRelatedBrands oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentProductId != widget.currentProductId) {
      setState(() {
        _products = ProductRepository().retrieveAllProduct();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _products = ProductRepository().retrieveAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    final brands = context.read<ReferencesValuesProviderCache>().brands;

    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Text(
            "Related Product",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          FutureBuilder(
            key: ValueKey(widget.currentProductId),
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(),
                );
              }

              if (snapshot.hasError) {
                return Text("Error");
              }

              if (snapshot.hasData && snapshot.data == null) {
                return Text("Error ");
              }

              // filter based on current product on preview
              final filteredList = snapshot.data!.where(
                (p) =>
                    (p.brand == widget.currentBrand &&
                    p.id != widget.currentProductId),
              );

              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: filteredList
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              widget.onTap(e);
                            },
                            child: ProductViewRelatedButton(
                              brand: referencesGetValueByID(
                                brands,
                                widget.currentBrand,
                              ),
                              model: e.model,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
