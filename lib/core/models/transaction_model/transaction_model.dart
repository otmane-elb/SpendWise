import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:typed_data';

import '../../../utils/extentions/unit8list_converter.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class Transaction with _$Transaction {
  @HiveType(typeId: 0, adapterName: 'TransactionAdapter')
  const factory Transaction({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required DateTime date,
    @HiveField(3) String? icon,
    @Uint8ListConverter() @HiveField(4) Uint8List? image,
    @HiveField(5) required bool isExpense,
    @HiveField(6) required double value,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}
