import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/bottom_sheet/reminder_bottom_sheet.dart';
import '../../../core/constant/app_colors_constant.dart';


class MedicineFloatButton extends StatelessWidget {
  const MedicineFloatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.secondary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: ReminderBottomSheet(),
          ),
        );
        context.read<MedicineReminderCubit>().resetValues();
      },
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );

  }
}
