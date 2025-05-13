import 'package:flutter/material.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/bottom_sheet/comments_field.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/image_selector_widget.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/bottom_sheet/medicine_dose_selector.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/bottom_sheet/medicine_name_field.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/reminder_add_button_widget.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/bottom_sheet/time_selector_widget.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/bottom_sheet/type_selector_widget.dart';

class ReminderBottomSheet extends StatelessWidget {
  const ReminderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 50,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          ImageSelector(),
          MedicineNameField(),
          const SizedBox(height: 16),
          MedicineTimePickerField(),
          const SizedBox(height: 16),
          Row(
            children: [
              MedicineDoseField(),
              const SizedBox(width: 16),
              TypeSelectorField(),
            ],
          ),
          const SizedBox(height: 16),
          const MedicineCommentsField(),
          const SizedBox(height: 30),
          const AddMedicineButton(),
        ],
      ),
    );
  }
}
