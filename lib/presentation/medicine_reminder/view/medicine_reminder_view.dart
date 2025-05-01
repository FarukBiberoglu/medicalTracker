import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/float_button_widget.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/medicine_reminder_card_widget.dart';

import '../cubit/medicine_reminder_cubit.dart';
import '../cubit/medicine_reminder_cubit_view.dart';

class MedicineReminderView extends StatelessWidget {
  const MedicineReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('İlaç Hatırlatıcı')),
      floatingActionButton: const MedicineFloatButton(),
      body: BlocBuilder<MedicineReminderCubit, MedicineReminderCubitState>(
        builder: (context, state) {
          if (state.medicineModel.isEmpty) {
            return const Center(
              child: Text('Henüz ilaç eklenmedi.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: state.medicineModel.length,
            itemBuilder: (context, index) {
              final medicine = state.medicineModel[index];
              return MedicineCard(medicine: medicine);
            },
          );
        },
      ),
    );
  }
}
