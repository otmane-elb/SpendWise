import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_data.freezed.dart';
part 'financial_data.g.dart';

@freezed
class FinancialData with _$FinancialData {
  const factory FinancialData({
    required double balance,
    required double income,
    required double expense,
  }) = _FinancialData;

  factory FinancialData.fromJson(Map<String, dynamic> json) => _$FinancialDataFromJson(json);
}
