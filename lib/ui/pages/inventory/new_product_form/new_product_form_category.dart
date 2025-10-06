import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';

class NewProductFormCategory extends StatefulWidget {
  const NewProductFormCategory({super.key});

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
      spacing: 10,
      children: [
        CustomDropdown(
          entries: categories,
          label: "Select Category",
          onSelected: (value) => context.read<ProductFormBloc>().add(
            ProductFormUpdateData(
              key: ProductFormKeys.category,
              value: value,
            ),
          ),
        ),
        // new category button
        CustomButton(
          child: Center(
            child: Text("New Category"),
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
