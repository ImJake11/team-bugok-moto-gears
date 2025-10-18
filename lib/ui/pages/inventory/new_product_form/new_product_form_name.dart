import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/helpers/references_get_id_by_value.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';

class NewProductFormName extends StatefulWidget {
  final TextEditingController modelController;
  final int selectedBrand;

  const NewProductFormName({
    super.key,
    required this.modelController,
    required this.selectedBrand,
  });

  @override
  State<NewProductFormName> createState() => _NewProductFormNameState();
}

class _NewProductFormNameState extends State<NewProductFormName> {
  late List<String> _usedModels;
  Timer? _debounce;
  bool _isError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retriveUsedModels();
  }

  void _onModelControllerDebounce() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer.periodic(
      Duration(seconds: 3),
      (_) {
        final s = context.read<ProductFormBloc>().state;

        if (s is! ProductFormInitial) {
          _debounce?.cancel();
          return;
        }

        _isError = _usedModels.any(
          (element) =>
              element.toLowerCase() ==
              widget.modelController.text.toLowerCase(),
        );
        setState(() {});
      },
    );
  }

  Future<void> _retriveUsedModels() async {
    final result = await ProductRepository().retrieveProductModel();

    result.removeWhere((element) => element == widget.modelController.text);

    setState(() {
      _usedModels = result;
    });
  }

  @override
  void dispose() {
    if (_debounce != null) {
      _debounce!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cacheProvider = context.read<ReferencesValuesProviderCache>();

    List<(int, String)> brandReferences = cacheProvider.brands;

    List<String> dropDownEntries = brandReferences
        .map<String>(
          (e) => e.$2,
        )
        .toList();

    final brand = referencesGetValueByID(brandReferences, widget.selectedBrand);

    return FormWrapper(
      title: "Brand and Model Management",
      child: Column(
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // dropdown for product brand
          CustomDropdown(
            selectedValue: brand,
            width: 500,
            onSelected: (value) {
          
              final brandId = referenceGetIdByValue(brandReferences, value!);

              context.read<ProductFormBloc>().add(
                ProductFormUpdateData(
                  key: ProductFormKeys.brand,
                  value: brandId,
                ),
              );
            },
            entries: dropDownEntries,
            label: "Brand",
          ),
          CustomTextfield(
            fillColor: Theme.of(context).colorScheme.surface,
            showShadow: false,
            textEditingController: widget.modelController,
            onChange: (value) {
              _onModelControllerDebounce();
              context.read<ProductFormBloc>().add(
                ProductFormUpdateData(
                  key: ProductFormKeys.model,
                  value: value,
                ),
              );
            },
            placeholder: "Model",
          ),
          if (_isError)
            Text(
              "A product with this model name already exists",
              style: TextStyle(
                color: Colors.red.shade700,
              ),
            ),
        ],
      ),
    );
  }
}
