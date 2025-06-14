import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled19/core/enum/blood_type_enum.dart';
import 'package:untitled19/core/enum/gender_enum.dart';
import 'package:untitled19/core/enum/role_enum.dart';
import 'package:untitled19/data/models/user_model.dart';
import 'package:untitled19/presentation/profile/cubit/profile_cubit_state.dart';
import '../../../core/router/app_router.dart';
import '../../../data/repositories/auth_repositories.dart';
import '../../../data/service/service_locator.dart';
import '../../authentication/cubit/auth/auth_cubit.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  ProfileCubit() : super(ProfileCubitState(
    gender: GenderEnum.Male,
    bloodType: BloodTypeEnum.ABPositive
  ))
  {
    final uid = getIt<AppRouter>().navigatorKey.currentState!.context.read<AuthCubit>().state.user?.uid;
    if (uid != null) {
      getIt.get<AuthRepository>().getUserData(uid).then((e) {
        if (e != null) {
          emit(state.copyWith(userModel: e));
        }
      }).catchError((e) {
        print('Profil verisi çekilirken hata: $e');
      });
    }

  }
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();


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

  Future<void> addProfile() async{
    final  filePath = state.imagePath;

    final ref = _storage.ref().child('profile_images/${state.fileName}');
    final uploadTask = filePath==null ?null : ref.putFile(File(filePath));
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot?.ref.getDownloadURL();
    final newModel = UserModel(
      phoneNumber:getIt<AppRouter>().navigatorKey.currentState!.context.read<AuthCubit>().state.user?.phoneNumber ??'',
      email: getIt<AppRouter>().navigatorKey.currentState!.context.read<AuthCubit>().state.user?.email ??'',
      role: RoleEnum.hasta,
      uid: getIt<AppRouter>().navigatorKey.currentState!.context.read<AuthCubit>().state.user?.uid ?? '',
      imagePath: downloadUrl,
      location:  state.location ?? '',
      height:  state.height ?? 0,
      weight: state.weight ?? 0,
      fullName: (state.firstName ?? '')+ '\t'+( state.lastName ?? ''),
      disease: state.disease ?? '',
      age: state.age ?? 0,
      bloodType: state.bloodType ?? BloodTypeEnum.ABNegative,
      gender: state.gender ?? GenderEnum.Male,

    );
    await getIt.get<AuthRepository>().updateUserModel(newModel);

    emit(state.copyWith(
      location: null,
      height: null,
      weight: null,
      firstName: null,
      lastName: null,
      bloodType: null,
      disease: null,
      age: null,
      gender: null,
      userModel: newModel,
    ));


}
  Future<void> pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final filePath = pickedImage.path;
      final fileName = pickedImage.name;
      emit(state.copyWith(imagePath: filePath,fileName: fileName));


    } catch (e, st) {
      print('Resim seçme ve yükleme hatası: $e\n$st');
      emit(state.copyWith(errorMessage: 'Resim seçme ve yükleme hatası'));
    }
  }
  }



