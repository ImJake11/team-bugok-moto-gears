import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/widgets/cancel_button.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class NewProductFormActions extends StatelessWidget {
  const NewProductFormActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductFormBloc, ProductFormState, ProductModel?>(
      selector: (state) {
        if (state is ProductFormInitial) {
          return state.productData;
        }
        return null;
      },
      builder: (context, value) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 20,
          children: [
            CancelButton(),
            if (value?.id == 0)
              CustomButton(
                width: 200,
                child: Center(
                  child: Text(
                    "Save & Create Another",
                  ),
                ),
              ),
            CustomButton(
              onTap: () => value?.id == 0
                  ? context.read<ProductFormBloc>().add(
                      ProductFormInsertProduct(isSaveOnly: true),
                    )
                  : context.read<ProductFormBloc>().add(
                      ProductFormSaveUpdateProduct(productModel: value!),
                    ),
              child: Center(
                child: Text(
                  value?.id == 0 ? "Save" : "Save Update",
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
