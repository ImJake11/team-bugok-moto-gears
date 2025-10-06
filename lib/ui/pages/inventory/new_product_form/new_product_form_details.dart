import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';

class NewProductFormDetails extends StatefulWidget {
  const NewProductFormDetails({super.key});

  @override
  State<NewProductFormDetails> createState() => _NewProductFormDetailsState();
}

class _NewProductFormDetailsState extends State<NewProductFormDetails> {
  @override
  Widget build(BuildContext context) {
    final List<String> availableColor = [
      "blue",
      "deepPurple",
      "green",
      "teal",
      "amber",
      "orange",
      "redAccent",
      "pink",
      "indigo",
      "grey",
    ];

    final List<String> availableSizes = [
      "extraSmall",
      "small",
      "mediumSmall",
      "medium",
      "mediumLarge",
      "large",
      "extraLarge",
      "xxLarge",
      "xxxLarge",
      "huge",
    ];

    return FormWrapper(
      title: "Product Details",
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomDropdown(
            onSelected: (value) => context.read<ProductFormBloc>().add(
              ProductFormUpdateData(key: ProductFormKeys.color, value: value),
            ),
            entries: availableColor,
            label: "Select Color",
          ),
          CustomDropdown(
            onSelected: (value) => context.read<ProductFormBloc>().add(
              ProductFormUpdateData(key: ProductFormKeys.size, value: value),
            ),
            entries: availableSizes,
            label: "Select Size",
          ),
        ],
      ),
    );
  }
}
