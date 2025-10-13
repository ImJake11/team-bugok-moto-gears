import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';

class NewProductFormCategory extends StatefulWidget {
  final String selectedCategory;

  const NewProductFormCategory({super.key, required this.selectedCategory});

  @override
  State<NewProductFormCategory> createState() => _NewProductFormCategoryState();
}

class _NewProductFormCategoryState extends State<NewProductFormCategory> {
  @override
  Widget build(BuildContext context) {
    // dummy
    final List<String> categories = [
      "Helmet",
      "Gear",
      "Dock tail",
      "Gloves",
    ];

    var child = Row(
      children: [
        CustomDropdown(
          width: 500,
          entries: categories,
          selectedValue: widget.selectedCategory,
          label: "Select Category",
          onSelected: (value) => context.read<ProductFormBloc>().add(
            ProductFormUpdateData(
              key: ProductFormKeys.category,
              value: value,
            ),
          ),
        ),
      ],
    );

    return FormWrapper(
      topBorderRadius: 10,
      title: "Category",
      child: child,
    );
  }
}
