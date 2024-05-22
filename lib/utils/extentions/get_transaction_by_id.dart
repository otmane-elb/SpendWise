import 'package:hive_flutter/hive_flutter.dart';
import 'package:spendwise/core/models/transaction_model/transaction_model.dart';

Transaction? getTransactionById(String id) {
  final box = Hive.box<Transaction>('transactions');
  return box.values.cast<Transaction?>().firstWhere(
        (transaction) => transaction?.id == id,
        orElse: () => null,
      );
}
