import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/widgets/text_field/custom_textfield.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';


class MedicineCommentsField extends StatelessWidget {
  const MedicineCommentsField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineReminderCubit>();

    return CustomTextFields(
      controller: cubit.commentsController,
      label: 'Comments',
      icon: Icons.comment_outlined,
      onChanged: (value) => cubit.comments(value),
    );
  }
}
