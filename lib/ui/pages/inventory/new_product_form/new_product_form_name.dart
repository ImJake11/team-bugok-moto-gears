import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';

class NewProductFormName extends StatelessWidget {
  const NewProductFormName({super.key});

  @override
  Widget build(BuildContext context) {
    return FormWrapper(
      title: "Product Name",
      child: Row(
        children: [
          CustomTextfield(
            onChange: (value) => context.read<ProductFormBloc>().add(
              ProductFormUpdateData(
                key: ProductFormKeys.productName,
                value: value,
              ),
            ),
            placeholder: "Type here..",
          ),
        ],
      ),
    );
  }
}
