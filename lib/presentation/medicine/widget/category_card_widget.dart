import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant/app_colors_constant.dart';
import '../cubit/appointment_cubit.dart';
import '../cubit/appointment_cubit_state.dart';
import '../enum/category_enum.dart';

class CategoryCardWidget extends StatelessWidget {
  final CategoryEnum category;

  const CategoryCardWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandevuCubit, RandevuCubitState>(
      builder: (context, state) {
        bool isSelected = state.selectedCategory == category;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              context.read<RandevuCubit>().selectCategory(category);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
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
                  width: 1.5,
                ),
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    category.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppColors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
