part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {
  final List<SalesModel> sales;

  DashboardInitial({required this.sales});
}

