import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/ui/widgets/custom_button.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class PosPageSearchbar extends StatefulWidget {
  const PosPageSearchbar({super.key});

  @override
  State<PosPageSearchbar> createState() => _PosPageSearchbarState();
}

class _PosPageSearchbarState extends State<PosPageSearchbar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return BlocListener<PosBloc, PosState>(
      listener: (context, state) {
        if (state is PosProductInitialized) {
          _controller.value = TextEditingValue(
            text: state.query,
            selection: TextSelection.collapsed(offset: state.query.length),
          );
        }
      },
      child: SizedBox(
        height: 50,
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CustomTextfield(
                    maxLength: 60,
                    textEditingController: _controller,
                    suffixIcon: Icons.search,
                    placeholder: "Search Model",
                    fillColor: theme.surfaceDim,
                    width: constraints.maxWidth,
                    showSuffixIcon: _controller.text.isNotEmpty,
                    onSuffixClick: () {
                      _controller.clear();
                      context.read<PosBloc>().add(
                        PosSearchBarSuffixIconClicked(),
                      );
                    },
                  );
                },
              ),
            ),
            CustomButton(
              onTap: () {
                context.read<PosBloc>().add(PosSearch(query: _controller.text));
              },
              child: Center(
                child: Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
