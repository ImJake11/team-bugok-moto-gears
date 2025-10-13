import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

String computeCartTotal(
  BuildContext context,
) {
  final s = context.read<PosBloc>().state;

  if (s is! PosProductInitialized) return "0";

  final cart = s.cart;

  final result = cart.fold<double>(
    0.00,
    (previousValue, element) {
      final total = element.price * element.quantity;

      return previousValue += total;
    },
  );

  // expecting double
  return currencyFormatter(result);
}
