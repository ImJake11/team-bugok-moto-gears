import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/stock_controller.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/toggle_switch.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/references_get_id_by_value.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';
import 'package:team_bugok_business/utils/services/get_available_sizes.dart';

class NewProductFormSizes extends StatelessWidget {
  final int selectedSize;
  final int variantIndex;
  final int index;
  final VariantSizeModel size;

  const NewProductFormSizes({
    super.key,
    required this.selectedSize,
    required this.variantIndex,
    required this.index,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final sizeValue = referencesGetValueByID(
      context,
      ReferenceType.sizes,
      size.sizeValue,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 100),
      child: Row(
        spacing: 20,
        children: [
          CustomDropdown(
            width: 150,
            selectedValue: sizeValue,
            entries: availableSizes(
              context,
              variantIndex,
              sizeValue,
            ),
            onSelected: (value) {
              final sizeId = referenceGetIdByValue(
                context,
                ReferenceType.sizes,
                value!,
              );

              context.read<ProductFormBloc>().add(
                ProductFormUpdateSize(
                  variantIndex: variantIndex,
                  sizeIndex: index,
                  size: sizeId,
                ),
              );
            },
            label: "Select Size",
          ),
          StockController(
            sizeIndex: index,
            currentStock: size.stock,
            variantIndex: variantIndex,
          ),
          size.id == null
              ? Transform(
                  transform: Matrix4.translationValues(20, 0, 0),
                  child: GestureDetector(
                    onTap: () => context.read<ProductFormBloc>().add(
                      ProductFormDeleteSize(
                        variantIndex: variantIndex,
                        sizeIndex: index,
                      ),
                    ),
                    child: Tooltip(
                      message: "Delete this size",
                      child: Icon(Icons.delete),
                    ),
                  ),
                )
              : CustomToggleSwitch(
                  onChange: (_) => context.read<ProductFormBloc>().add(
                    ProductFormDeleteSize(
                      variantIndex: variantIndex,
                      sizeIndex: index,
                    ),
                  ),
                  isActive: size.isActive == 1,
                ),
        ],
      ),
    );
  }
}
