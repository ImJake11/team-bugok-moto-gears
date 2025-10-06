import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';

class NewProductFormStock extends StatelessWidget {
  const NewProductFormStock({super.key});

  @override
  Widget build(BuildContext context) {
    return FormWrapper(
      bottomBorderRadius: 10,
      title: "Stock",
      child: CustomTextfield(
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        placeholder: "Quantity",
        onChange: (value) => context.read<ProductFormBloc>().add(
          ProductFormUpdateData(
            key: ProductFormKeys.stock,
            value: value,
          ),
        ),
      ),
    );
  }
}
