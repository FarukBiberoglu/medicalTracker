import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/widgets/text_field/custom_textfield.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';


class MedicineNameField extends StatelessWidget {
  const MedicineNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineReminderCubit>();

    return CustomTextFields(
      controller: cubit.medicineNameController,
      label: 'Medicine Name',
      icon: Icons.medication_outlined,
      onChanged: (value) => cubit.medicineName(value),
    );
  }
}
