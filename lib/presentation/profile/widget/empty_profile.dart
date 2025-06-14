import 'package:flutter/material.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/core/constant/app_string_constant.dart';
import 'package:untitled19/core/utils/bottom_sheet_helper.dart';
import 'package:untitled19/core/widgets/sizedbox/directional_sizedbox.dart';
import 'package:untitled19/presentation/profile/widget/profile_bottom_sheet_widget.dart';


class EmptyProfileWidget extends StatelessWidget {
  const EmptyProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_add, size: 100, color: Colors.blueGrey[700]),
          DirectionalSizedBox(20),
          Text(
            AppStrings.createProfile,
            style:
            Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          DirectionalSizedBox(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              AppStrings.byCreating,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          DirectionalSizedBox(30),
          ElevatedButton(
            onPressed: () => showCustomBottomSheet(context, ProfileBottomSheet()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Create Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
