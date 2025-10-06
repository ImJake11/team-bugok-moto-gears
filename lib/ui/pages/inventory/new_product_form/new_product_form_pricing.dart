import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';

class NewProductFormPricing extends StatelessWidget {
  const NewProductFormPricing({super.key});

  @override
  Widget build(BuildContext context) {
    var child = Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTextfield(
          width: 400,
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
          width: 400,
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

    return FormWrapper(title: "Pricing", child: child);
  }
}
