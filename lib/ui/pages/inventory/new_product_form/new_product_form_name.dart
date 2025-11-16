import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/helpers/references_get_id_by_value.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';

class NewProductFormName extends StatefulWidget {
  final String model;
  final int selectedBrand;

  const NewProductFormName({
    super.key,
    required this.model,
    required this.selectedBrand,
  });

  @override
  State<NewProductFormName> createState() => _NewProductFormNameState();
}

class _NewProductFormNameState extends State<NewProductFormName> {
  List<String> _usedModels = [];
  Timer? _debounce;
  bool _isError = false;

  @override
  void didUpdateWidget(covariant NewProductFormName oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.model != widget.model) {
      // check if model is existin
      bool isExisting = _usedModels.any(
        (element) => element.contains(widget.model),
      );

      setState(() => _isError = isExisting);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _retriveUsedModels(),
    );
  }

  Future<void> _retriveUsedModels() async {
    final result = await ProductRepository().retrieveProductModel();

    result.removeWhere((element) => element == widget.model);

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

    final brand = referencesGetValueByID(
      context,
      ReferenceType.brands,
      widget.selectedBrand,
    );

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
              final brandId = referenceGetIdByValue(
                context,
                ReferenceType.brands,
                value!,
              );

              context.read<ProductFormBloc>().add(
                ProductFormUpdateData(
                  key: ProductFormKeys.brand,
                  value: brandId,
                ),
              );
            },
            entries: dropDownEntries,
            label: "Select Brand",
          ),
          CustomDropdown(
            width: 500,
            entries: cacheProvider.models
                .map(
                  (e) => e.$2,
                )
                .toList(),
            label: "Select Model",
            selectedValue: widget.model,
            onSelected: (value) {
              context.read<ProductFormBloc>().add(
                ProductFormUpdateData(
                  key: ProductFormKeys.model,
                  value: value,
                ),
              );
            },
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
