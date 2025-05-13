import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/presentation/authentication/cubit/auth/auth_cubit.dart';
import 'package:untitled19/presentation/profile/cubit/profile_cubit.dart';
import 'package:untitled19/presentation/profile/cubit/profile_cubit_state.dart';
import 'package:untitled19/presentation/profile/widget/profile_bottom_sheet_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileCubit, ProfileCubitState>(
        builder: (context, state) {
          if (state.profileModel.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_add,
                    size: 100,
                    color: Colors.blueGrey[700],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Create your profile to get started",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "By creating a profile, you'll be able to personalize your experience, save your data, and more.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                        ),
                        builder:
                            (context) => Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 20,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20,
                              ),
                              child: ProfileBottomSheet(),
                            ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Create Profile",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final profile = state.profileModel.last;

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -50,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              state.imagePath == null
                                  ? null
                                  : FileImage(File(state.imagePath!)),
                          child:
                              state.imagePath == null
                                  ? Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.grey.shade600,
                                  )
                                  : null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),

                // Name and age section
                Column(
                  children: [
                    Text(
                      "${profile.firstName} ${profile.lastName}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
                const SizedBox(height: 12),

                // Personal Information Section
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Title for Personal Information
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _profileTile('Age', "${profile.age} ", Icons.bike_scooter),
                     _profileTile('Location', "${profile.location} ", Icons.location_on),

                      //PHONE NUMBER
                      _profileTile(
                        "Phone Number ",
                        ' +90 ${context.watch<AuthCubit>().state.user?.phoneNumber?.replaceFirst(RegExp(r'^0'), '') ?? ''}',
                        Icons.fitness_center,
                      ),
                      
                    ],
                  ),
                ),

                // Health Information Section
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Title for Health Information
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Health Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _profileTile(
                        "Blood Type",
                        profile.bloodType?.value ?? "Not Specified",
                        Icons.bloodtype,
                      ),
                      _profileTile(
                        "Weight",
                        "${profile.weight} kg",
                        Icons.fitness_center,
                      ),

                      _profileTile(
                        "Height",
                        "${profile.height} cm",
                        Icons.height,
                      ),
                      _profileTile(
                        "Disease",
                        profile.disease.isEmpty ? "None" : profile.disease,
                        Icons.healing,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // Edit Profile Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                        ),
                        builder:
                            (context) => Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 20,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20,
                              ),
                              child: ProfileBottomSheet(),
                            ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                
                ),
                SizedBox(height: 30,),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _profileTile(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
