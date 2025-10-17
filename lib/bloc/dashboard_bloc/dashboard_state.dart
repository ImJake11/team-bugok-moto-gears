part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {
  final DateTime currentDate;
  final List<SalesModel> sales;
  final List<ProductModel> products;
  final List<VariantSizeModel> sizes;
  final List<ExpensesModel> expenses;

  DashboardInitial({
    required this.currentDate,
    required this.sales,
    required this.products,
    required this.sizes,
    required this.expenses,
  });
}

class DashboardFilteringData extends DashboardEvent {}

class DashboardFilterSuccessful extends DashboardEvent {}

class DashboardFilterError extends DashboardEvent {}
