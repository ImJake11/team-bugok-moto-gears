import 'package:team_bugok_business/utils/model/cart_model.dart';

class SalesModel {
  final int? id;
  final int createdAt;
  final double total;
  final List<CartModel> items;

  SalesModel({
    this.id,
    required this.createdAt,
    required this.total,
    required this.items,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
      id: json['id'],
      createdAt: json['created_at'],
      total: json['total'],
      items: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'created_at': createdAt,
      'total': total,
    };
  }
}
