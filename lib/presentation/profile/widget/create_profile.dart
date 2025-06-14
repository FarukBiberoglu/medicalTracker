import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/core/extension/padding_extension.dart';
import 'package:untitled19/core/utils/bottom_sheet_helper.dart';
import 'package:untitled19/core/widgets/sizedbox/directional_sizedbox.dart';
import 'package:untitled19/presentation/authentication/cubit/auth/auth_cubit.dart';
import 'package:untitled19/presentation/profile/cubit/profile_cubit_state.dart';
import 'package:untitled19/presentation/profile/widget/profile_bottom_sheet_widget.dart';
import 'package:untitled19/presentation/profile/widget/profile_card.dart';
import 'package:untitled19/presentation/profile/widget/section_tile.dart';
import 'package:untitled19/presentation/profile/widget/profile_tile_field.dart';

class ProfileDetailView extends StatelessWidget {
  final ProfileCubitState state;

  const ProfileDetailView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final profile = state.userModel;

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 109,
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
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child:CircleAvatar(
                    backgroundColor:
                    state.imagePath == null ? Colors.grey : Colors.transparent,
                    radius: 55,
                    backgroundImage: profile?.imagePath == null ? null : NetworkImage(profile!.imagePath!),
                  ),


                ),
              ),
            ],
          ),
          DirectionalSizedBox(55),

          // NAME
          Text(
            "${profile?.fullName}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          DirectionalSizedBox(30),

          // Personal Info
          const SectionTitle(title: "Personal Information"),
          ProfileCard(
            children: [
              ProfileTitle(
                icon: Icons.cake_outlined,
                title: 'Age',
                value: '${profile?.age}',
              ),
              ProfileTitle(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: profile?.location ?? '',
              ),
              ProfileTitle(
                icon: Icons.phone_outlined,
                title: 'Phone',
                value:
                    '+90 ${context.read<AuthCubit>().state.user?.phoneNumber.replaceFirst(RegExp(r'^0'), '') ?? ''}',
              ),
            ],
          ),

          DirectionalSizedBox(20),

          // Health Info
          const SectionTitle(title: "Health Information"),
          ProfileCard(
            children: [
              ProfileTitle(
                icon: Icons.bloodtype,
                title: 'Blood Type',
                value: profile?.bloodType?.value ?? "Not Specified",
              ),
              ProfileTitle(
                icon: Icons.monitor_weight_outlined,
                title: 'Weight',
                value: "${profile?.weight} kg",
              ),
              ProfileTitle(
                icon: Icons.height,
                title: 'Height',
                value: "${profile?.height} cm",
              ),
              ProfileTitle(
                icon: Icons.medical_services,
                title: 'Disease',
                value: profile?.disease ?? "None",
              ),
            ],
          ),

          DirectionalSizedBox(20),

          ElevatedButton.icon(
            onPressed:
                () => showCustomBottomSheet(
                  context,
                  const ProfileBottomSheet(),
                ),
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text(
              "Edit Profile",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ).symmetricPadding(horizontal: 16),
DirectionalSizedBox(30),
        ],
      ),
    );
  }
}
