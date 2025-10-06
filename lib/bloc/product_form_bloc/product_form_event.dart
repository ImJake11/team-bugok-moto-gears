part of 'product_form_bloc.dart';

@immutable
sealed class ProductFormEvent {}

class ProductFormUpdateData extends ProductFormEvent {
  final String key;
  final dynamic value;

  ProductFormUpdateData({
    required this.key,
    required this.value,
  });
}
