import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';

class NewProductFormPricing extends StatelessWidget {
  final TextEditingController costPriceController;
  final TextEditingController sellingPriceController;

  const NewProductFormPricing({
    super.key,
    required this.costPriceController,
    required this.sellingPriceController,
  });

  @override
  Widget build(BuildContext context) {
    var child = Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTextfield(
          fillColor: Theme.of(context).colorScheme.surface,
          showShadow: false,
          width: 400,
          textEditingController: costPriceController,
          placeholder: "Cost Price",
          onChange: (value) => context.read<ProductFormBloc>().add(
            ProductFormUpdateData(key: ProductFormKeys.costPrice, value: value),
          ),
          suffixIcon: LucideIcons.philippinePeso,
          formatter: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
        CustomTextfield(
          fillColor: Theme.of(context).colorScheme.surface,
          showShadow: false,
          width: 400,
          textEditingController: sellingPriceController,
          onChange: (value) => context.read<ProductFormBloc>().add(
            ProductFormUpdateData(
              key: ProductFormKeys.sellingPrice,
              value: value,
            ),
          ),
          placeholder: "Selling Price",
          suffixIcon: LucideIcons.philippinePeso,
          formatter: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ],
    );

    return FormWrapper(
      bottomBorderRadius: 10,
      title: "Pricing",
      child: child,
    );
  }
}
