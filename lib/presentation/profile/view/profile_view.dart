import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/profile/cubit/profile_cubit.dart';
import 'package:untitled19/presentation/profile/cubit/profile_cubit_state.dart';
import 'package:untitled19/presentation/profile/widget/create_profile.dart';
import 'package:untitled19/presentation/profile/widget/empty_profile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileCubit, ProfileCubitState>(
        builder: (context, state) {
          if (state.userModel == null) {
            return const EmptyProfileWidget();
          }
          return ProfileDetailView(state: state);
        },
      ),
    );
  }
}
