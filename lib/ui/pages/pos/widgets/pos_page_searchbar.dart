import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class PosPageSearchbar extends StatelessWidget {
  const PosPageSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: theme.surfaceDim,
        borderRadius: BorderRadius.circular(10),
        boxShadow: theme.shadow,
        border: Border.all(
          color: theme.primary,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomTextfield(
            onChange: (value) =>
                context.read<PosBloc>().add(PosSearch(query: value)),
            suffixIcon: Icons.search,
            placeholder: "Search Model",
            fillColor: theme.surfaceDim,
            width: constraints.maxWidth,
          );
        },
      ),
    );
  }
}
