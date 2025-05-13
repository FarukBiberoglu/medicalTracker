import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled19/presentation/profile/cubit/profile_cubit_state.dart';
import 'package:untitled19/presentation/profile/enum/blood_type_enum.dart';
import 'package:untitled19/presentation/profile/enum/gender_enum.dart';
import 'package:untitled19/presentation/profile/model/profile_model.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  ProfileCubit() : super(ProfileCubitState(
    gender: GenderEnum.Male,
    bloodType: BloodTypeEnum.ABPositive
  ));

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();


  void selectedGender(GenderEnum gender) {
    emit(state.copyWith(gender: gender));
  }
  void selectBloodType (BloodTypeEnum bloodType){
    emit(state.copyWith(bloodType: bloodType));
  }
  void location (String location){
    emit(state.copyWith(location: location));
  }

  void firstName(String value) {
    emit(state.copyWith(firstName: value));
  }

  void lastName(String value) {
    emit(state.copyWith(lastName: value));
  }

  void userAge(int age) {
    emit(state.copyWith(age: age));
  }
  void userWeight(int weight) {
    emit(state.copyWith(weight: weight));
  }

  void userHeight(int height) {
  emit(state.copyWith(height: height)); 
}


  void disease(String value) {
    emit(state.copyWith(disease: value));
  }

 void addProfile() {
  if (state.firstName == null || state.lastName == null || state.age == null) {
    emit(state.copyWith(errorMessage: () => "Please fill all required fields"));
    return;
  }

  final newModel = ProfileModel(
    location:  state.location ?? '',
    height:  state.height ?? 0,
    weight: state.weight ?? 0,
    firstName: state.firstName ?? '',
    lastName: state.lastName ?? '',
    disease: state.disease ?? '',
    age: state.age ?? 0,
    bloodType: state.bloodType ?? BloodTypeEnum.ABNegative,
    gender: state.gender ?? GenderEnum.Male,
  );

  final updatedList = [...state.profileModel, newModel];

  emit(state.copyWith(
    location: null,
    height: null,
    weight: null,
    profileModel: updatedList,
    firstName: null,
    lastName: null,
    bloodType: null,
    disease: null,
    age: null,
    gender: null,
    imagePath: null,
  ));


}


  Future<void> pickImage() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
          source: ImageSource.gallery);

      if (pickedImage != null) {
        emit(state.copyWith(imagePath: () => pickedImage.path));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: () => 'error '));
    }
  }

}