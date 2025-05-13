import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/text_field_widget.dart';


class MedicineDoseField extends StatelessWidget {
  const MedicineDoseField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineReminderCubit>();

    return Expanded(
      child: CustomField(
        keyboardType: TextInputType.phone,
        controller: cubit.doseController,
        label: 'Dose',
        icon: Icons.local_pharmacy_outlined,
        onChanged: (value) => cubit.dose(int.tryParse(value) ?? 1),
      ),
    );
  }
}
