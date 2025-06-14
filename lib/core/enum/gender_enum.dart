
import 'package:hive/hive.dart';
part 'gender_enum.g.dart';

@HiveType(typeId: 7)
enum GenderEnum {
  @HiveField(0)
  Male,
  @HiveField(1)
  Female,
}