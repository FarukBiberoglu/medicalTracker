import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/extension/padding_extension.dart';
import '../../../core/constant/app_colors_constant.dart';
import '../cubit/appointment_cubit.dart';
import '../cubit/appointment_cubit_state.dart';
import 'package:untitled19/core/enum/category_enum.dart';

class CategoryCardWidget extends StatelessWidget {
  final CategoryEnum category;
  const CategoryCardWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentCubitState>(
      builder: (context, state) {
        final isSelected = state.selectedCategory == category;

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.read<AppointmentCubit>().selectCategory(category),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: isSelected
                  ? LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
                  : null,
              color: isSelected ? null : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.black12,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                category.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.black,
                ),
              ),
            ),
          ),
        ).allPadding(10);
      },
    );
  }
}
