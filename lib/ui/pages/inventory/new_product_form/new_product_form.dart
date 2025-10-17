import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_actions.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_category.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_details.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_name.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form_pricing.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/active_toggle.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/widgets/timeline_component.dart';
import 'package:team_bugok_business/ui/widgets/appbar.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/ui/widgets/nav_back_button.dart';
import 'package:team_bugok_business/ui/widgets/snackbar.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';

class NewProductForm extends StatefulWidget {
  const NewProductForm({super.key});

  @override
  State<NewProductForm> createState() => _NewProductFormState();
}

class _NewProductFormState extends State<NewProductForm> {
  final _modelController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _costPriceController = TextEditingController();

  bool _isInitialized = false;

  @override
  void dispose() {
    _modelController.dispose();
    _costPriceController.dispose();
    _sellingPriceController.dispose();
    super.dispose();
  }

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
          BlocSelector<ProductFormBloc, ProductFormState, int>(
            selector: (state) =>
                (state is ProductFormInitial) ? state.productData.id ?? 0 : 0,
            builder: (context, id) {
              return Text(
                "Product ID: ${id}",
                style: TextStyle(
                  fontSize: 18,
                ),
              );
            },
          ),
          Expanded(child: const SizedBox()),
          ActiveToggle(),
        ],
      ),
    );

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) => didPop
          ? context.read<ProductFormBloc>().add(ProductFormResetForm())
          : null,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          spacing: 20,
          children: [
            CustomAppbar(
              child: appbar,
            ),
            Expanded(
              child: BlocListener<ProductFormBloc, ProductFormState>(
                listener: (context, state) {
                  if (!_isInitialized && state is ProductFormInitial) {
                    final sellingPrice = state.productData.sellingPrice;
                    final costPrice = state.productData.costPrice;

                    _modelController.text = state.productData.model;

                    _sellingPriceController.text = sellingPrice <= 0
                        ? ""
                        : sellingPrice.toString();

                    _costPriceController.text = costPrice <= 0
                        ? ""
                        : costPrice.toString();
                    _isInitialized = true;
                  }

                  if (state is ProductFormShowSnackbar) {
                    CustomSnackBar(
                      context: context,
                      message: state.message,
                      duration: state.duration,
                    ).show();
                  }

                  if (state is ProductFormValidtionError) {
                    CustomSnackBar(
                      context: context,
                      message: state.message,
                    ).show();
                  }

                  if (state is ProductFormErrorState) {
                    context.read<LoadingProvider>().closeLoading();
                    CustomSnackBar(
                      context: context,
                      message: state.message,
                    ).show();
                  }

                  if (state is ProductFormSaveProduct) {
                    bool isSaveOnly = state.isSaveOnly;

                    CustomSnackBar(
                      context: context,
                      message: "Product Updated Successfully",
                    ).show();

                    if (isSaveOnly) {
                      context.goNamed("inventory");
                    }
                    context.read<LoadingProvider>().closeLoading();
                  }
                },
                child: BlocBuilder<ProductFormBloc, ProductFormState>(
                  builder: (context, state) {
                    if (state is ProductFormLoadingState) {
                      return Center(
                        child: LoadingWidget(),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            BlocSelector<
                              ProductFormBloc,
                              ProductFormState,
                              String
                            >(
                              selector: (state) => state is ProductFormInitial
                                  ? state.productData.category
                                  : '',
                              builder: (context, category) {
                                return TimelineComponent(
                                  isLast: false,
                                  isPast: category.isNotEmpty,
                                  isFirst: true,
                                  child: NewProductFormCategory(
                                    selectedCategory: category,
                                  ),
                                );
                              },
                            ),

                            BlocSelector<
                              ProductFormBloc,
                              ProductFormState,
                              (String, String)
                            >(
                              selector: (state) {
                                if (state is ProductFormInitial) {
                                  return (
                                    state.productData.brand,
                                    state.productData.model,
                                  );
                                }
                                return ('', '');
                              },
                              builder: (context, brandModel) {
                                final (brand, model) = brandModel;
                                return TimelineComponent(
                                  isLast: false,
                                  isPast: brand.isNotEmpty && model.isNotEmpty,
                                  isFirst: false,
                                  child: NewProductFormName(
                                    selectedBrand: brand,
                                    modelController: _modelController,
                                  ),
                                );
                              },
                            ),

                            BlocSelector<
                              ProductFormBloc,
                              ProductFormState,
                              bool
                            >(
                              selector: (state) => state is ProductFormInitial
                                  ? state.productData.variants.isNotEmpty
                                  : false,
                              builder: (context, isNotEmpty) {
                                return TimelineComponent(
                                  isLast: false,
                                  isPast: isNotEmpty,
                                  isFirst: false,
                                  child: const NewProductFormDetails(),
                                );
                              },
                            ),

                            BlocSelector<
                              ProductFormBloc,
                              ProductFormState,
                              (double, double)
                            >(
                              selector: (state) {
                                if (state is ProductFormInitial) {
                                  return (
                                    state.productData.costPrice,
                                    state.productData.sellingPrice,
                                  );
                                }
                                return (0.0, 0.0);
                              },
                              builder: (context, priceData) {
                                final (costPrice, sellingPrice) = priceData;
                                return TimelineComponent(
                                  isLast: false,
                                  isPast: costPrice != 0 && sellingPrice != 0,
                                  isFirst: false,
                                  child: NewProductFormPricing(
                                    costPriceController: _costPriceController,
                                    sellingPriceController:
                                        _sellingPriceController,
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 60),
                            const NewProductFormActions(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
