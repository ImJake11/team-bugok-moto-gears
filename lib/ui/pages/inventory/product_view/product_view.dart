import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/product_view_preview.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/product_view_related_brands.dart';
import 'package:team_bugok_business/ui/widgets/appbar.dart';
import 'package:team_bugok_business/ui/widgets/nav_back_button.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class ProductView extends StatefulWidget {
  final ProductModel productModel;

  const ProductView({super.key, required this.productModel});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late ProductModel _productModel;
  int _selectedColor = 0;

  void _selectProduct(ProductModel productModel) {
    setState(() {
      _selectedColor = 0;
      _productModel = productModel;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productModel = widget.productModel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppbar(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [NavBackButton()],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
              child: Row(
                spacing: 20,
                children: [
                  ProductViewPreview(
                    onTap: (index) => setState(() => _selectedColor = index),
                    selectedColor: _selectedColor,
                    productModel: _productModel,
                  ),
                  ProductViewRelatedBrands(
                    onTap: _selectProduct,
                    currentProductId: _productModel.id!,
                    currentBrand: _productModel.brand,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
