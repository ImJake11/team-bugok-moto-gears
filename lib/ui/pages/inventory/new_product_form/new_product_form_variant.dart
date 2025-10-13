import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_sizes.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/toggle_switch.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/ui/widgets/error_button.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';
import 'package:team_bugok_business/utils/services/get_available_colors.dart';

class NewProductFormVariant extends StatefulWidget {
  final int variantIndex;
  final bool isActive;
  final int? id;

  const NewProductFormVariant({
    super.key,
    required this.variantIndex,
    required this.isActive,
    this.id,
  });

  @override
  State<NewProductFormVariant> createState() => _NewProductFormVariantState();
}

class _NewProductFormVariantState extends State<NewProductFormVariant> {
  late List<TextEditingController> _stockControllers;
  bool isNewSizeButtonHovered = false;

  @override
  void initState() {
    super.initState();

    final s = context.read<ProductFormBloc>().state as ProductFormInitial;

    _stockControllers = s.productData.variants[widget.variantIndex].sizes
        .map((v) => TextEditingController(text: v.stock.toString()))
        .toList();
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
    // add size button
    Widget addSizeBtn() {
      return MouseRegion(
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
                    ? Theme.of(context).colorScheme.primary
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
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10)
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
                BlocSelector<ProductFormBloc, ProductFormState, String>(
                  selector: (state) {
                    if (state is ProductFormInitial) {
                      final variants = state.productData.variants;

                      if (variants.length > widget.variantIndex) {
                        return variants[widget.variantIndex].color;
                      }
                    }
                    return '';
                  },
                  builder: (context, selectedColor) {
                    return CustomDropdown(
                      width: 250,
                      selectedValue: selectedColor,
                      onSelected: (value) =>
                          context.read<ProductFormBloc>().add(
                            ProductFormUpdateVariant(
                              variantIndex: widget.variantIndex,
                              colorValue: value ?? "",
                            ),
                          ),
                      entries: availableColors(context, selectedColor),
                      label: "Select Color",
                    );
                  },
                ),
                Spacer(),
                addSizeBtn(),

                widget.id == null
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
                        isActive: widget.isActive,
                      ),
              ],
            ),

            // SIZED LIST
            BlocSelector<
              ProductFormBloc,
              ProductFormState,
              List<VariantSizeModel>
            >(
              selector: (state) {
                if (state is ProductFormInitial &&
                    widget.variantIndex < state.productData.variants.length) {
                  return state.productData.variants[widget.variantIndex].sizes;
                }
                return [];
              },
              builder: (context, sizes) {
                for (int i = 0; i < sizes.length; i++) {
                  if (i >= _stockControllers.length) {
                    // New controller for new size row
                    _stockControllers.add(
                      TextEditingController(text: sizes[i].stock.toString()),
                    );
                  }
                }

                // Dispose extra controllers if any
                while (_stockControllers.length > sizes.length) {
                  _stockControllers.removeLast().dispose();
                }

                return sizes.isEmpty
                    ? SizedBox()
                    : Column(
                        spacing: 30,
                        children: List.generate(
                          sizes.length,
                          (index) {
                            return NewProductFormSizes(
                              selectedSize: sizes[index].sizeValue,
                              stockController: _stockControllers[index],
                              index: index,
                              variantIndex: widget.variantIndex,
                              size: sizes[index],
                            );
                          },
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
