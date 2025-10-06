import 'package:intl/intl.dart';

String currencyFormatter(double amount) {
  final formatCurrency = NumberFormat.currency(
    locale: 'en_PH', // Philippines locale
    symbol: '₱', // Peso sign
    decimalDigits: 2, // Optional, 0 if you want no decimals
  );

  return formatCurrency.format(amount);
}
