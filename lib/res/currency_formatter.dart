import 'package:intl/intl.dart';

class CurrencyFormatter {
  static double fromFormattedPrice(String price) {
    final sanitizedString = price.replaceAll('\$', '').replaceAll(',', '');
    return double.parse(sanitizedString);
  }

  static String formatCurrency(double amount) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      symbol: '\$',
    );
    return currencyFormatter.format(amount);
  }
}
