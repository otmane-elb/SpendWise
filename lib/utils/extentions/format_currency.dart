import 'package:intl/intl.dart';

class FormatCurrency {
  String formatCurrency(double amount) {
    return NumberFormat("#,##0.00", "en_US").format(amount);
  }
}
