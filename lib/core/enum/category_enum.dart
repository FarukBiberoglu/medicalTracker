
import 'package:hive/hive.dart';
part 'category_enum.g.dart';

@HiveType(typeId: 4)
enum CategoryEnum {

  @HiveField(0)
  upcoming('Upcoming'),

  @HiveField(1)
  completed('Completed'),

  @HiveField(2)
  canceled('Canceled');

  const CategoryEnum(this.title);
  final String title;
}