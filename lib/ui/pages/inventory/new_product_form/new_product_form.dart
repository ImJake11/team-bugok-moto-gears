import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_actions.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_category.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_details.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_name.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_pricing.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_stock.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/active_toggle.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/timeline_component.dart';
import 'package:team_bugok_business/ui/widgets/appbar.dart';
import 'package:team_bugok_business/ui/widgets/nav_back_button.dart';

class NewProductForm extends StatelessWidget {
  const NewProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final appbar = Padding(
      padding: const EdgeInsets.only(
        right: 30,
        left: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NavBackButton(),
          SizedBox(width: 35),
          Text(
            "Product ID: ${2103908}",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Expanded(child: const SizedBox()),
          ActiveToggle(),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        spacing: 20,
        children: [
          CustomAppbar(
            child: appbar,
          ),
          Expanded(
            child: BlocBuilder<ProductFormBloc, ProductFormState>(
              builder: (context, state) {
                if (state is ProductFormInitial) {
                  return ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    children: [
                      // TIMELINE COMPONENTS
                      TimelineComponent(
                        isLast: false,
                        isPast:
                            state.category != null &&
                            state.category!.isNotEmpty,
                        isFirst: true,
                        child: NewProductFormCategory(),
                      ),
                      TimelineComponent(
                        isLast: false,
                        isPast: state.productName!.isNotEmpty,
                        isFirst: false,
                        child: NewProductFormName(),
                      ),
                      TimelineComponent(
                        isLast: false,
                        isPast: state.size != "" && state.color != "",
                        isFirst: false,
                        child: NewProductFormDetails(),
                      ),
                      TimelineComponent(
                        isLast: false,
                        isPast: state.sellingPrice != 0 && state.costPrice != 0,
                        isFirst: false,
                        child: NewProductFormPricing(),
                      ),
                      TimelineComponent(
                        isLast: true,
                        isPast: state.stock != 0,
                        isFirst: false,
                        child: NewProductFormStock(),
                      ),

                      const SizedBox(height: 60),
                      NewProductFormActions(),
                      const SizedBox(height: 20),
                    ],
                  );
                }

                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
