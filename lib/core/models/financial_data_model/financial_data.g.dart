// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FinancialDataImpl _$$FinancialDataImplFromJson(Map<String, dynamic> json) =>
    _$FinancialDataImpl(
      balance: (json['balance'] as num).toDouble(),
      income: (json['income'] as num).toDouble(),
      expense: (json['expense'] as num).toDouble(),
    );

Map<String, dynamic> _$$FinancialDataImplToJson(_$FinancialDataImpl instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'income': instance.income,
      'expense': instance.expense,
    };
