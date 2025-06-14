import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/core/constant/app_string_constant.dart';
import 'package:untitled19/core/extension/padding_extension.dart';
import 'package:untitled19/core/widgets/sizedbox/directional_sizedbox.dart';
import 'package:untitled19/presentation/authentication/cubit/auth/auth_cubit.dart';

class AppointmentWelcomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppointmentWelcomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<AuthCubit>().state.user?.fullName ?? '';

    return Container(
      width: double.infinity,
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.appBarGrey,
            AppColors.White,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, $userName',
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                DirectionalSizedBox(6),
                Text(
                  AppStrings.manageAppointment,
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.notifications, color: Colors.black54),
            ),
          ],
        ),
      ).symmetricPadding(horizontal: 25, vertical: 22),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
