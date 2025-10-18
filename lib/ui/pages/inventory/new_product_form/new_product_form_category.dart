import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/form_wrapper.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/utils/helpers/references_get_id_by_value.dart';
import 'package:team_bugok_business/utils/helpers/references_get_value_by_id.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';

class NewProductFormCategory extends StatelessWidget {
  final int selectedCategory;

  const NewProductFormCategory({
    super.key,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final cacheProvider = context.read<ReferencesValuesProviderCache>();

    List<(int, String)> categoryReferences = cacheProvider.categories;

    final category = referencesGetValueByID(
      categoryReferences,
      selectedCategory,
    );

    final categoryEntries = categoryReferences.map((e) => e.$2).toList();

    var child = Row(
      children: [
        CustomDropdown(
          width: 500,
          entries: categoryEntries,
          selectedValue: category,
          label: "Select Category",
          onSelected: (value) {
            final categoryId = referenceGetIdByValue(
              categoryReferences,
              value!,
            );
            context.read<ProductFormBloc>().add(
              ProductFormUpdateData(
                key: ProductFormKeys.category,
                value: categoryId,
              ),
            );
          },
        ),
      ],
    );

    return FormWrapper(
      topBorderRadius: 10,
      title: "Category",
      child: child,
    );
  }
}
