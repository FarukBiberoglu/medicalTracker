
import 'package:hive/hive.dart';
part 'blood_type_enum.g.dart';

@HiveType(typeId: 6)
enum BloodTypeEnum {
  @HiveField(0)
  APositive('A+'),
  @HiveField(1)
  ANegative('A-'),
  @HiveField(2)
  BPositive('B+'),
  @HiveField(3)
  BNegative('B-'),
  @HiveField(4)
  ABPositive('AB+'),
  @HiveField(5)
  ABNegative('AB-'),
  @HiveField(6)
  OPositive('O+'),
  @HiveField(7)
  ONegative('O-');

  final String value;
  const BloodTypeEnum(this.value);

  @override
  String toString() => value;
}