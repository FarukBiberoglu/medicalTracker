import 'package:untitled19/presentation/profile/enum/blood_type_enum.dart';
import 'package:untitled19/presentation/profile/enum/gender_enum.dart';

class ProfileModel {
  final String firstName;
  final String lastName;
  final int age;
  final String disease;
  final BloodTypeEnum? bloodType;
  final GenderEnum? gender;
  final String? imagePath;
  final int? weight;
  final int? height;
  final String? location;

  ProfileModel({
    required this.location,
    required this.height,
    required this.weight,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.disease,
    this.bloodType,
    this.gender,
    this.imagePath,
  });


}
