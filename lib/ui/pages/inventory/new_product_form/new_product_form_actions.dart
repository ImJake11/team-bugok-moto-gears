import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/widgets/cancel_button.dart';
import 'package:team_bugok_business/ui/widgets/custom_button.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';

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
            CancelButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
            if (value?.id == null)
              CustomButton(
                width: 200,
                onTap: () {
                  context.read<ProductFormBloc>().add(
                    ProductFormInsertProduct(isSaveOnly: false),
                  );
                },
                child: Center(
                  child: Text(
                    "Save & Create Another",
                  ),
                ),
              ),
            CustomButton(
              onTap: () {
                context.read<LoadingProvider>().showLoading("Saving Product");
                if (value?.id == null) {
                  context.read<ProductFormBloc>().add(
                    ProductFormInsertProduct(isSaveOnly: true),
                  );
                } else {
                  context.read<ProductFormBloc>().add(
                    ProductFormSaveUpdateProduct(productModel: value!),
                  );
                }
              },
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
