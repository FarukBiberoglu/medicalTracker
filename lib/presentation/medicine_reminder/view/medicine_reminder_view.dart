import 'package:flutter/material.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/float_button_widget.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/medicine_reminder_body_widget.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/reminder_app_bar.dart';


class MedicineReminderView extends StatelessWidget {
  const MedicineReminderView({super.key});

  @override
  Widget build(BuildContext context) {

  

    return Scaffold(
      appBar: ReminderAppBar(),
      floatingActionButton: const MedicineFloatButton(),
      body:MedicineReminderBody(),
    );
  }
}
