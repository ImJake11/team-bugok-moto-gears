class TopProductsMdodel {
  final int id;
  final String brand;
  final String model;
  final int sales;

  TopProductsMdodel({
    required this.id,
    required this.brand,
    required this.model,
    required this.sales,
  });

  TopProductsMdodel copyWith({
    int? id,
    String? brand,
    String? model,
    int? sales,
  }) => TopProductsMdodel(
    id: id ?? this.id,
    brand: brand ?? this.brand,
    model: model ?? this.model,
    sales: sales ?? this.sales,
  );
}
