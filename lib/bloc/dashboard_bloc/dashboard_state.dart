part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {
  final List<SalesModel> sales;
  final List<ProductModel> products;
  final List<VariantSizeModel> sizes;

  DashboardInitial({
    required this.sales,
    required this.products,
    required this.sizes,
  });
}
