import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';

class ActiveToggle extends StatelessWidget {
  const ActiveToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<ProductFormBloc, ProductFormState>(
      builder: (context, state) {
        if (state is ProductFormInitial) {
          return Row(
            spacing: 10,
            children: [
              Text(
                state.isActive ? "Active" : "Inactive",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: state.isActive,
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
