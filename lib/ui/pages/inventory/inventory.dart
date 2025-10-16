import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:team_bugok_business/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/inventoryTable.dart';
import 'package:team_bugok_business/ui/widgets/appbar.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';

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
            fillColor: Theme.of(context).colorScheme.surfaceDim,
            onChange: (value) {
              _searchQuery();
            },
          ),
          const Spacer(),
          newGearButton,
        ],
      ),
    );

    var body = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            if (state is InventoryInitial) {
              final isFiltering = state.isFiltering;
              final searchResults = state.searchResults;
              final products = state.products;

              return InventoryTable(
                products: isFiltering ? searchResults : products,
              );
            }

            if (state is InventoryErrorState) {
              return Center(
                child: Text('Something went wrong'),
              );
            }

            return Center(
              child: Transform(
                transform: Matrix4.translationValues(-80, 0, 0),
                child: LoadingWidget(),
              ),
            );
          },
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
