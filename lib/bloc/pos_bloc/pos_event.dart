part of 'pos_bloc.dart';

@immutable
sealed class PosEvent {}

class PosLoadProducts extends PosEvent {}

class PosSearch extends PosEvent {
  final String query;

  PosSearch({required this.query});
}

class PosAddProductCart extends PosEvent {
  final CartModel cartModel;

  PosAddProductCart({required this.cartModel});
}

class PosSelectProduct extends PosEvent {
  final int productID;

  PosSelectProduct({required this.productID});
}

class PosQuantityAction extends PosEvent {
  final int id;
  final bool isAdd;

  PosQuantityAction({required this.id, required this.isAdd});
}

class PosDeleteCartItem extends PosEvent {
  final int id;

  PosDeleteCartItem({required this.id});
}

class PosCheckOutItems extends PosEvent {}