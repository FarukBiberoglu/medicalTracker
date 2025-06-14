import 'package:equatable/equatable.dart';
import 'package:untitled19/data/models/user_model.dart';
import 'package:untitled19/core/enum/blood_type_enum.dart';
import 'package:untitled19/core/enum/gender_enum.dart';

class ProfileCubitState extends Equatable {
  final int? weight;
  final int? height;
  final String? imagePath;
  final String? imageUrl;
  final String? errorMessage;
  final String? firstName;
  final String? lastName;
  final int? age;
  final String? disease;
  final BloodTypeEnum? bloodType;
  final GenderEnum? gender;
  final UserModel? userModel;
  final String? location;
  final String? fileName;

  const ProfileCubitState({
    this.fileName,
    this.imageUrl,
    this.location,
    this.height,
    this.weight,
    this.imagePath,
    this.errorMessage,
    this.userModel,
    this.firstName,
    this.lastName,
    this.age,
    this.disease,
    this.bloodType,
    this.gender,
  });

  ProfileCubitState copyWith({
    String? fileName,
    String? imageUrl,
    String? location,
    int? height,
    int? weight,
    String? imagePath,
    String? errorMessage,
    String? firstName,
    String? lastName,
    int? age,
    String? disease,
    BloodTypeEnum? bloodType,
    GenderEnum? gender,
    UserModel? userModel,
  }) {
    return ProfileCubitState(
      fileName: fileName ?? this.fileName,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      imagePath: imagePath ?? this.imagePath,
      errorMessage: errorMessage ?? this.errorMessage,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      disease: disease ?? this.disease,
      bloodType: bloodType ?? this.bloodType,
      gender: gender ?? this.gender,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [
    fileName,
    imageUrl,
    location,
    weight,
    height,
    errorMessage,
    imagePath,
    firstName,
    lastName,
    age,
    disease,
    bloodType,
    gender,
    userModel,
  ];
}
