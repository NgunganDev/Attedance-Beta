// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DbmodelAdapter extends TypeAdapter<Dbmodel> {
  @override
  final int typeId = 1;

  @override
  Dbmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dbmodel(
      instansiName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dbmodel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.instansiName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
