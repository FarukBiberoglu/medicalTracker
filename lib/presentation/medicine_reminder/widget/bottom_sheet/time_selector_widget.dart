import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/widgets/text_field/custom_textfield.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';


class MedicineTimePickerField extends StatelessWidget {
  const MedicineTimePickerField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineReminderCubit>();

    return CustomTextFields(
      controller: cubit.medicineDateController,
      label: 'Select Time',
      icon: Icons.access_time,
      readOnly: true,
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 7)),
        );
        if (date == null || !context.mounted) return;

        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time == null || !context.mounted) return;

        cubit.onChangedMedicineDate(
          DateTime(date.year, date.month, date.day, time.hour, time.minute),
        );
      },
    );
  }
}
