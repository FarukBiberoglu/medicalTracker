import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/text_field_widget.dart';


class MedicineNameField extends StatelessWidget {
  const MedicineNameField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineReminderCubit>();

    return CustomField(
      controller: cubit.medicineNameController,
      label: 'Medicine Name',
      icon: Icons.medication_outlined,
      onChanged: (value) => cubit.medicineName(value),
    );
  }
}
