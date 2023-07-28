import 'package:hive/hive.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 1)
class Dbmodel {
  @HiveField(0)
  final String instansiName;
  Dbmodel({required this.instansiName});
}
