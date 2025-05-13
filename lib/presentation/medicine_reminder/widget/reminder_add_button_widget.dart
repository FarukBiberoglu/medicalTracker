import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';


class AddMedicineButton extends StatelessWidget {
  const AddMedicineButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text(
          "Add",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        onPressed: () {
          final cubit = context.read<MedicineReminderCubit>();
          if (cubit.medicineDateController.text.isEmpty ||
              cubit.commentsController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please fill in all fields')),
            );
            return;
          }
          cubit.addMedicine();
          Navigator.pop(context);
        },
      ),
    );
  }
}
