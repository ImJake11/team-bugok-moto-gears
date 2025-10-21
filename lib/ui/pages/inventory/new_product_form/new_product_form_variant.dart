import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_sizes.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/toggle_switch.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/ui/widgets/error_button.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/references_get_id_by_value.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/get_available_colors.dart';

class NewProductFormVariant extends StatefulWidget {
  final VariantModel variantModel;
  final int variantIndex;

  const NewProductFormVariant({
    super.key,
    required this.variantIndex,
    required this.variantModel,
  });

  @override
  State<NewProductFormVariant> createState() => _NewProductFormVariantState();
}

class _NewProductFormVariantState extends State<NewProductFormVariant> {
  List<TextEditingController> _stockControllers = [];
  bool isNewSizeButtonHovered = false;

  @override
  void initState() {
    super.initState();
    _initializedControllers();
  }

  @override
  void didUpdateWidget(covariant NewProductFormVariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.variantModel != widget.variantModel) {
      _initializedControllers();
    }
  }

  void _initializedControllers() {
    if (widget.variantModel.sizes.isNotEmpty) {
      _stockControllers = widget.variantModel.sizes
          .map((v) => TextEditingController(text: v.stock.toString()))
          .toList();
    }
    setState(() {});
  }

  @override
  void dispose() {
    for (var c in _stockControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    VariantModel variant = widget.variantModel;

    List<VariantSizeModel> sizes = variant.sizes;

    final selectedColor = referencesGetValueByID(
      context,
      ReferenceType.colors,
      variant.color,
    );

    Widget addSizeBtn() => MouseRegion(
      onEnter: (event) => setState(() => isNewSizeButtonHovered = true),
      onExit: (event) => setState(() => isNewSizeButtonHovered = false),
      child: GestureDetector(
        onTap: () => context.read<ProductFormBloc>().add(
          ProductFormCreateSize(
            variantIndex: widget.variantIndex,
          ),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: Border.all(
              color: isNewSizeButtonHovered
                  ? theme.primary
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Text('New Size'),
          ),
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 40,
          children: [
            Row(
              spacing: 20,
              children: [
                CustomDropdown(
                  width: 250,
                  selectedValue: selectedColor,
                  onSelected: (value) {
                    final colorId = referenceGetIdByValue(
                      context,
                      ReferenceType.colors,
                      value!,
                    );

                    context.read<ProductFormBloc>().add(
                      ProductFormUpdateVariant(
                        variantIndex: widget.variantIndex,
                        colorValue: colorId,
                      ),
                    );
                  },
                  entries: availableColors(
                    context,
                    selectedColor,
                  ),
                  label: "Select Color",
                ),
                Spacer(),
                addSizeBtn(),

                variant.id == null
                    ? CustomErrorButton(
                        ontap: () => context.read<ProductFormBloc>().add(
                          ProductFormDeleteVariant(
                            variantIndex: widget.variantIndex,
                          ),
                        ),
                        child: Center(child: Text('Delete')),
                      )
                    : CustomToggleSwitch(
                        onChange: (_) => context.read<ProductFormBloc>().add(
                          ProductFormDeleteVariant(
                            variantIndex: widget.variantIndex,
                          ),
                        ),
                        isActive: variant.isActive == 1,
                      ),
              ],
            ),

            // SIZED LIST
            if (sizes.isNotEmpty)
              Column(
                spacing: 30,
                children: List.generate(
                  sizes.length,
                  (index) {
                    final selectedSize = sizes[index].sizeValue;

                    return NewProductFormSizes(
                      selectedSize: selectedSize,
                      index: index,
                      variantIndex: widget.variantIndex,
                      size: sizes[index],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
