import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/bottom_sheet/bottom_sheet_image_card_widget.dart';
import 'package:untitled19/core/enum/select_medicine.dart';
class ImageSelector extends StatelessWidget {
  const ImageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedMedicine = context.watch<MedicineReminderCubit>().state.selectedMedicine;
    final cubit = context.read<MedicineReminderCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageCardWidget(
            title: 'pills',
            isSelected: selectedMedicine == SelectMedicine.pills,
            imagePath: 'assets/pills.png',
            onTap: () => cubit.selectMedicine(SelectMedicine.pills),
          ),
          const SizedBox(width: 8),
          ImageCardWidget(
            title: 'Capcule',
            isSelected: selectedMedicine == SelectMedicine.capcule,
            imagePath: 'assets/capcule.png',
            onTap: () => cubit.selectMedicine(SelectMedicine.capcule),
          ),
          const SizedBox(width: 8),
          ImageCardWidget(
            title: 'Liquid',
            isSelected: selectedMedicine == SelectMedicine.liguid,
            imagePath: 'assets/liguid.png',
            onTap: () => cubit.selectMedicine(SelectMedicine.liguid),
          ),
          const SizedBox(width: 8),
          ImageCardWidget(
            title: 'Eyedrops',
            isSelected: selectedMedicine == SelectMedicine.eyedrops,
            imagePath: 'assets/eyedrops.png',
            onTap: () => cubit.selectMedicine(SelectMedicine.eyedrops),
          ),
        ],
      ),
    );
  }
}
