import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_variant.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';

class NewProductFormDetails extends StatefulWidget {
  const NewProductFormDetails({super.key});

  @override
  State<NewProductFormDetails> createState() => _NewProductFormDetailsState();
}

class _NewProductFormDetailsState extends State<NewProductFormDetails> {
  @override
  Widget build(BuildContext context) {
    return FormWrapper(
      title: "Variants Management",
      child: BlocSelector<ProductFormBloc, ProductFormState, int>(
        selector: (state) {
          if (state is ProductFormInitial) {
            return state.productData.variants.length;
          }
          return 0;
        },
        builder: (context, length) => Column(
          spacing: 30,
          children: [
            if (length > 0)
              ...List.generate(
                length,
                (index) => NewProductFormVariant(
                  variantIndex: index,
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onTap: () => context.read<ProductFormBloc>().add(
                    ProductFormCreateVariant(),
                  ),
                  child: Center(
                    child: Text("Add Variant"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
