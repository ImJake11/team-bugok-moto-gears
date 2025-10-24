import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:team_bugok_business/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/inventoryTable.dart';
import 'package:team_bugok_business/ui/widgets/appbar.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/ui/widgets/padding_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final _searchController = TextEditingController();
  Timer? _debounce;

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
            return Center(
              child: Text('Something went wrong'),
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
