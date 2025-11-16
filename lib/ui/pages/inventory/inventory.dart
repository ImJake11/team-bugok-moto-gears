import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:team_bugok_business/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/inventoryTable.dart';
import 'package:team_bugok_business/ui/widgets/appbar.dart';
import 'package:team_bugok_business/ui/widgets/error_button.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/ui/widgets/padding_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/custom_button.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  late final ProductRepository _productRepository;

  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productRepository = ProductRepository();
    final state = context.read<InventoryBloc>().state;

    if (state is InventoryInitial) {
      if (state.products.isEmpty) _loadProducts();
    }
  }

  Future<void> _loadProducts() async {
    try {
      context.read<InventoryBloc>().add(InventoryToggleLoadingState());
      final products = await _productRepository.retrieveAllProduct();

      context.read<InventoryBloc>().add(
        InventoryLoadInitialData(products: products),
      );
    } catch (e) {
      context.read<InventoryBloc>().add(InventoryErrorOccurs());
    }
  }

  void _searchQuery() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(
      Duration(milliseconds: 500),
      () {
        final query = _searchController.text.trim().toLowerCase();

        context.read<InventoryBloc>().add(
          InventoryFilteringList(query: query),
        );
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
            width: 16,
            color: Colors.white,
            colorBlendMode: BlendMode.srcIn,
          ),
          Text(
            "Add Product",
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );

    var appbar = Row(
      spacing: 10,
      children: [
        CustomTextfield(
          textEditingController: _searchController,
          suffixIcon: LucideIcons.search,
          placeholder: "Search Model",
          fillColor: context.watch<MyThemeProvider>().surfaceDim,
          onChange: (value) {
            _searchQuery();
          },
        ),
        const Spacer(),
        newGearButton,
      ],
    );

    var body = Expanded(
      child: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          if (state is InventoryLoadingState) {
            return Center(
              child: LoadingWidget(),
            );
          } else if (state is InventoryInitial) {
            final isFiltering = state.isFiltering;
            final searchResults = state.searchResults;
            final products = state.products;

            if (products.isEmpty) {
              return Center(
                child: Text("No products found"),
              );
            }

            return InventoryTable(
              products: isFiltering ? searchResults : products,
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text('Something went wrong'),
                SizedBox(
                  child: CustomErrorButton(
                    ontap: () => _loadProducts(),
                    color: Colors.red,
                    width: 100,
                    child: Center(
                      child: Text("Retry"),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );

    return PaddingWrapper(
      child: Column(
        spacing: 10,
        children: [
          CustomAppbar(child: appbar),
          body,
        ],
      ),
    );
  }
}
