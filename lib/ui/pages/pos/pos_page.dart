import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/ui/pages/pos/pos_page_cart.dart';
import 'package:team_bugok_business/ui/pages/pos/pos_page_products.dart';
import 'package:team_bugok_business/ui/widgets/date_time_display.dart';
import 'package:team_bugok_business/ui/pages/pos/widgets/pos_page_searchbar.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/ui/widgets/snackbar.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<PosBloc, PosState>(
            listener: (context, state) {
              if (state is PosCheckOutSuccessful) {
                CustomSnackBar(
                  context: context,
                  message: "Your purchase has been completed successfully",
                ).show();
              }

              if (state is PosErrorState) {
                CustomSnackBar(
                  context: context,
                  message: state.message,
                ).show();
              }
            },
            builder: (context, s) {
              if (s is PosLoadingState) {
                return Center(
                  child: LoadingWidget(),
                );
              }

              if (s is PosErrorState) {
                return Center(
                  child: Text('Something went wrong'),
                );
              }

              return Row(
                spacing: 30,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 20,
                      children: [
                        DateTimeDisplay(),
                        PosPageSearchbar(),
                        PosPageProducts(),
                      ],
                    ),
                  ),
                  PosPageCart(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
