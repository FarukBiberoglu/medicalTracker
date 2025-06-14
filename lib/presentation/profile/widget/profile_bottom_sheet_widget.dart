import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/profile/cubit/profile_cubit.dart';
import 'package:untitled19/presentation/profile/cubit/profile_cubit_state.dart';
import 'package:untitled19/core/enum/blood_type_enum.dart';
import 'package:untitled19/core/enum/gender_enum.dart';
import '../../../core/constant/app_colors_constant.dart';
import 'create_profile_textfield_widget.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<ProfileCubit,ProfileCubitState>(
      builder: (_,state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                controller: controller,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Top indicator
                    Container(
                      width: 60,
                      height: 6,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    // Profile image
                    GestureDetector(
                      onTap: () => context.read<ProfileCubit>().pickImage(),
                      child: Builder(
                        builder: (context) {
                          final imageUrl = context.select((ProfileCubit cubit) => cubit.state.imagePath);

                          return CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: state.imagePath != null
                              ? FileImage(File(state.imagePath!))
                                : null,
                            child: imageUrl == null
                                ? Icon(Icons.camera_alt, size: 40, color: Colors.grey.shade600)
                                : null,
                          );
                        },
                      ),
                    ),



                    const SizedBox(height: 24),

                    _buildDropdownField(
                      context,
                      label: "Gender",
                      value: state.gender?.name ?? "Select",
                      icon: Icons.wc,
                      onTap: () => _showGenderPicker(context, state),
                    ),
                    const SizedBox(height: 12),

                    ProfileTextField(
                      hint: 'First Name',
                      icon: Icons.person_outline,
                      controller: context.read<ProfileCubit>().firstNameController,
                      onChanged: context.read<ProfileCubit>().firstName,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextField(
                      hint: 'Last Name',
                      icon: Icons.person_outline,
                      controller: context.read<ProfileCubit>().lastNameController,
                      onChanged: context.read<ProfileCubit>().lastName,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextField(
                      hint: 'Disease',
                      icon: Icons.medical_services,
                      controller: context.read<ProfileCubit>().diseaseController,
                      onChanged: context.read<ProfileCubit>().disease,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextField(
                      hint: 'Age',
                      icon: Icons.cake,
                      keyboardType: TextInputType.number,
                      controller: context.read<ProfileCubit>().ageController,
                      onChanged: (value) => context.read<ProfileCubit>().userAge(int.tryParse(value) ?? 0),
                    ),
                    const SizedBox(height: 12),
                    ProfileTextField(
                      hint: 'Weight',
                      icon: Icons.monitor_weight_outlined,
                      keyboardType: TextInputType.number,
                      controller: context.read<ProfileCubit>().weightController,
                      onChanged: (value) => context.read<ProfileCubit>().userWeight(int.tryParse(value) ?? 0),
                    ),
                    const SizedBox(height: 12),
                    ProfileTextField(
                      hint: 'Height',
                      icon: Icons.height,
                      keyboardType: TextInputType.number,
                      controller: context.read<ProfileCubit>().sizeController,
                      onChanged: (value) => context.read<ProfileCubit>().userHeight(int.tryParse(value) ?? 0),
                    ),
                    const SizedBox(height: 12,),
                    ProfileTextField(
                      hint: 'Location',
                      icon: Icons.location_on,

                      controller: context.read<ProfileCubit>().locationController,
                      onChanged: context.read<ProfileCubit>().location,
                    ),
                    const SizedBox(height: 12),
                    _buildDropdownField(
                      context,
                      label: "Blood Type",
        value: state.bloodType?.value ?? "Select",
                      icon: Icons.bloodtype_outlined,
                      onTap: () => _showBloodTypePicker(context, state),
                    ),
                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileCubit>().addProfile(

                        );
                        Navigator.pop(context);
                      },child: Text('Add Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }


  Widget _buildDropdownField(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary),
            suffixIcon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  void _showGenderPicker(BuildContext context, ProfileCubitState state) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children: GenderEnum.values.map((gender) {
            return ListTile(
              title: Text(
                gender.name,
                style: TextStyle(
                  color: state.gender == gender ? AppColors.primary : Colors.black,
                  fontWeight:
                      state.gender == gender ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                context.read<ProfileCubit>().selectedGender(gender);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showBloodTypePicker(BuildContext context, ProfileCubitState state) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children: BloodTypeEnum.values.map((bloodType) {
            return ListTile(
              title: Text(
  bloodType.toString(), // veya bloodType.value
  style: TextStyle(
    color: state.bloodType == bloodType
        ? AppColors.primary
        : Colors.black,
    fontWeight: state.bloodType == bloodType
        ? FontWeight.bold
        : FontWeight.normal,
  ),
),

              onTap: () {
                Navigator.of(context).pop();
                context.read<ProfileCubit>().selectBloodType(bloodType);
              },
            );
          }).toList(),
        ); 
      },
    );
  }
}

