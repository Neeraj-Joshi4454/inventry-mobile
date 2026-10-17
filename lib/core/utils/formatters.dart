import 'package:intl/intl.dart';

/// Formatting helpers kept in one place so every screen renders money,
/// quantities, and dates the same way.
class Formatters {
  Formatters._();

  static final NumberFormat _currency = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2);

  static final NumberFormat _quantity = NumberFormat('#,##0.###');

  static final DateFormat _date = DateFormat('dd MMM yyyy');
  static final DateFormat _dateTime = DateFormat('dd MMM yyyy, hh:mm a');

  static String currency(num value) => _currency.format(value);

  /// Quantities are often whole numbers ("500 Bags") but can be fractional
  /// ("125.75 Kg") — this trims trailing zeros rather than always showing
  /// a fixed number of decimal places.
  static String quantity(num value) => _quantity.format(value);

  static String date(DateTime value) => _date.format(value);

  static String dateTime(DateTime value) => _dateTime.format(value);
}
