import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:team_bugok_business/ui/pages/inventory/inventoryTable.dart';
import 'package:team_bugok_business/ui/widgets/appbar.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  late final List<ProductModel> _products;
  List<ProductModel> _searchResult = [];

  final _searchController = TextEditingController();
  Timer? _debounce;

  bool _isInitialized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    _products = await ProductRepository().retrieveAllProduct();
    setState(() {
      _isInitialized = true;
    });
  }

  void _searchQuery() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer.periodic(
      Duration(milliseconds: 200),
      (_) {
        final query = _searchController.text.trim().toLowerCase();

        _searchResult = _products
            .where(
              (element) => element.model.toLowerCase().contains(query),
            )
            .toList();
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    if (_debounce != null) {
      _debounce!.cancel();
    }
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var newGearButton = CustomButton(
      onTap: () => GoRouter.of(context).pushNamed("new-product-form"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Image.asset(
            "assets/images/helmet.png",
            width: 20,
            color: Colors.white,
            colorBlendMode: BlendMode.srcIn,
          ),
          Text(
            "New Gear",
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );

    var appbar = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        spacing: 10,
        children: [
          CustomTextfield(
            textEditingController: _searchController,
            suffixIcon: LucideIcons.search,
            placeholder: "Search Model",
            onChange: (value) => _searchQuery(),
          ),
          Expanded(child: SizedBox()),
          newGearButton,
        ],
      ),
    );

    var body = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: _isInitialized
            ? InventoryTable(
                products: _searchController.text.isEmpty
                    ? _products
                    : _searchResult,
              )
            : Center(
                child: Transform(
                  transform: Matrix4.translationValues(-80, 0, 0),
                  child: LoadingWidget(),
                ),
              ),
      ),
    );

    return Column(
      spacing: 30,
      children: [
        CustomAppbar(child: appbar),
        body,
      ],
    );
  }
}
