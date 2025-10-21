import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class ActiveToggle extends StatelessWidget {
  const ActiveToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return BlocBuilder<ProductFormBloc, ProductFormState>(
      builder: (context, state) {
        if (state is ProductFormInitial) {
          return Row(
            spacing: 10,
            children: [
              Text(
                state.productData.isActive == 1 ? "Active" : "Inactive",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: state.productData.isActive == 1,
                onChanged: (value) => context.read<ProductFormBloc>().add(
                  ProductFormUpdateData(
                    key: ProductFormKeys.isActive,
                    value: value,
                  ),
                ),
                activeThumbColor: theme.primary,
                inactiveThumbColor: Colors.white60,
                mouseCursor: MouseCursor.defer,
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
