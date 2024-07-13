// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<_$TransactionImpl> {
  @override
  final int typeId = 0;

  @override
  _$TransactionImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TransactionImpl(
      id: fields[0] as String,
      title: fields[1] as String,
      date: fields[2] as DateTime,
      icon: fields[3] as String?,
      image: fields[4] as Uint8List?,
      isExpense: fields[5] as bool,
      value: fields[6] as double,
      order: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$TransactionImpl obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.isExpense)
      ..writeByte(6)
      ..write(obj.value)
      ..writeByte(7)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      icon: json['icon'] as String?,
      image: const Uint8ListConverter().fromJson(json['image'] as String?),
      isExpense: json['isExpense'] as bool,
      value: (json['value'] as num).toDouble(),
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'icon': instance.icon,
      'image': const Uint8ListConverter().toJson(instance.image),
      'isExpense': instance.isExpense,
      'value': instance.value,
      'order': instance.order,
    };
