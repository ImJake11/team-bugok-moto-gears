part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardLoadData extends DashboardEvent {}

class DashboardPickDate extends DashboardEvent {
  final DateTime referenceDate;

  DashboardPickDate({required this.referenceDate});
}
