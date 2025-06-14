import 'package:hive/hive.dart';

part 'type_enum.g.dart';
@HiveType(typeId: 1)
enum TypeEnum {
  @HiveField(0)
  Tabs,
  @HiveField(1)
  Piece,
  @HiveField(2)
  Mg,
  @HiveField(3)
  Gr
}