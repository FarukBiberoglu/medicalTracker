
import 'package:hive/hive.dart';
part 'select_medicine.g.dart';
@HiveType(typeId: 2)
enum SelectMedicine {
  @HiveField(0)
  pills(asset: 'assets/pills.png'),
  @HiveField(1)
  eyedrops(asset: 'assets/liguid.png'),
  @HiveField(2)
  liguid(asset: 'assets/eyedrops.png'),
  @HiveField(3)
  capcule(asset: 'assets/capcule.png');

  final String asset ;
  const SelectMedicine({required this.asset});
}