import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/text_field_widget.dart';


class MedicineCommentsField extends StatelessWidget {
  const MedicineCommentsField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineReminderCubit>();

    return CustomField(
      controller: cubit.commentsController,
      label: 'Comments',
      icon: Icons.comment_outlined,
      onChanged: (value) => cubit.comments(value),
    );
  }
}
