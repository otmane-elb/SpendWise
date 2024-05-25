// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FinancialData _$FinancialDataFromJson(Map<String, dynamic> json) {
  return _FinancialData.fromJson(json);
}

/// @nodoc
mixin _$FinancialData {
  double get balance => throw _privateConstructorUsedError;
  double get income => throw _privateConstructorUsedError;
  double get expense => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FinancialDataCopyWith<FinancialData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialDataCopyWith<$Res> {
  factory $FinancialDataCopyWith(
          FinancialData value, $Res Function(FinancialData) then) =
      _$FinancialDataCopyWithImpl<$Res, FinancialData>;
  @useResult
  $Res call({double balance, double income, double expense});
}

/// @nodoc
class _$FinancialDataCopyWithImpl<$Res, $Val extends FinancialData>
    implements $FinancialDataCopyWith<$Res> {
  _$FinancialDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? income = null,
    Object? expense = null,
  }) {
    return _then(_value.copyWith(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      income: null == income
          ? _value.income
          : income // ignore: cast_nullable_to_non_nullable
              as double,
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialDataImplCopyWith<$Res>
    implements $FinancialDataCopyWith<$Res> {
  factory _$$FinancialDataImplCopyWith(
          _$FinancialDataImpl value, $Res Function(_$FinancialDataImpl) then) =
      __$$FinancialDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double balance, double income, double expense});
}

/// @nodoc
class __$$FinancialDataImplCopyWithImpl<$Res>
    extends _$FinancialDataCopyWithImpl<$Res, _$FinancialDataImpl>
    implements _$$FinancialDataImplCopyWith<$Res> {
  __$$FinancialDataImplCopyWithImpl(
      _$FinancialDataImpl _value, $Res Function(_$FinancialDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? income = null,
    Object? expense = null,
  }) {
    return _then(_$FinancialDataImpl(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      income: null == income
          ? _value.income
          : income // ignore: cast_nullable_to_non_nullable
              as double,
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialDataImpl implements _FinancialData {
  const _$FinancialDataImpl(
      {required this.balance, required this.income, required this.expense});

  factory _$FinancialDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialDataImplFromJson(json);

  @override
  final double balance;
  @override
  final double income;
  @override
  final double expense;

  @override
  String toString() {
    return 'FinancialData(balance: $balance, income: $income, expense: $expense)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialDataImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.income, income) || other.income == income) &&
            (identical(other.expense, expense) || other.expense == expense));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, balance, income, expense);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialDataImplCopyWith<_$FinancialDataImpl> get copyWith =>
      __$$FinancialDataImplCopyWithImpl<_$FinancialDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FinancialDataImplToJson(
      this,
    );
  }
}

abstract class _FinancialData implements FinancialData {
  const factory _FinancialData(
      {required final double balance,
      required final double income,
      required final double expense}) = _$FinancialDataImpl;

  factory _FinancialData.fromJson(Map<String, dynamic> json) =
      _$FinancialDataImpl.fromJson;

  @override
  double get balance;
  @override
  double get income;
  @override
  double get expense;
  @override
  @JsonKey(ignore: true)
  _$$FinancialDataImplCopyWith<_$FinancialDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
