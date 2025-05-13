import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:untitled19/presentation/profile/enum/blood_type_enum.dart';
import 'package:untitled19/presentation/profile/enum/gender_enum.dart';
import '../model/profile_model.dart';

class ProfileCubitState extends Equatable {
  final int? weight;
  final int? height;
  final String? imagePath;
  final String? errorMessage;
  final String? firstName;
  final String? lastName;
  final int? age;
  final String? disease;
  final BloodTypeEnum? bloodType;
  final GenderEnum? gender;
  final List<ProfileModel> profileModel;
  final String? location;

  ProfileCubitState({
    this.location,
    this.height,
    this.weight,
    this.imagePath,
    this.errorMessage,
    this.profileModel = const [],
    this.firstName,
    this.lastName,
    this.age,
    this.disease,
    this.bloodType,
    this.gender,
  });

  ProfileCubitState copyWith({
    String? location,
    int? height,
    int? weight,
    ValueGetter<String?>? imagePath,
    ValueGetter<String?>? errorMessage,
    String? firstName,
    String? lastName,
    int? age,
    String? disease,
    BloodTypeEnum? bloodType,
    GenderEnum? gender,
    List<ProfileModel>? profileModel,
  }) {
    return ProfileCubitState(
      location:  location ?? this.location,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      imagePath: imagePath == null ? this.imagePath : imagePath.call(),
      errorMessage: errorMessage == null ? this.errorMessage : errorMessage.call(),
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      disease: disease ?? this.disease,
      bloodType: bloodType ?? this.bloodType,
      gender: gender ?? this.gender,
      profileModel: profileModel ?? this.profileModel,
    );
  }

  @override
  List<Object?> get props => [
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
    profileModel,
  ];
}
