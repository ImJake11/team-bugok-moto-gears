import 'package:team_bugok_business/utils/model/cart_model.dart';

class SalesModel {
  final int id;
  final DateTime createdAt;
  final double total;
  final List<CartModel> items;

  SalesModel({
    required this.id,
    required this.createdAt,
    required this.total,
    required this.items,
  });
}
