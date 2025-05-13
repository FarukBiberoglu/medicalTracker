import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/core/extantions/date_extantion.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit_state.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/medicine_reminder_card_widget.dart';
import 'package:untitled19/presentation/medicine_reminder/widget/search_field_widget.dart';


class MedicineReminderBody extends StatelessWidget {
  const MedicineReminderBody({super.key});

  @override
  Widget build(BuildContext context) {
 List<DateTime> last7Days = List.generate(14, (index) {
      return DateTime.now().subtract(Duration(days: 6 - index));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom Search Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomSearchField(
            controller: context.read<MedicineReminderCubit>().searchController,
            hintText: 'Search medicine...',
            onChanged: (value) {
              context.read<MedicineReminderCubit>().onChangedSearchController(value);
            },
          ),
        ),

        const SizedBox(height: 12),

        // Horizontal Scroll for Date Selection
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: last7Days.map((date) {
                final isSelected = context.watch<MedicineReminderCubit>().state.selectDateTime.isSameDay(date);
                return GestureDetector(
                  onTap: () {
                    context.read<MedicineReminderCubit>().selectDate(date);
                  },
                  child: Container(
                    width: 48,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                      ],
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.grey.shade300,
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('EEE').format(date), // Mon, Tue...
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${date.day}', // 1, 2, 3...
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Expanded Grid View for Medicine Cards
        Expanded(
          child: BlocBuilder<MedicineReminderCubit, MedicineReminderCubitState>(
            builder: (context, state) {
              final list = state.medicineModel.where((element) {
                return element.medicineDate.isSameDay(state.selectDateTime) &&
                    element.medicineName.contains(state.search);
              }).toList();

              if (list.isEmpty) {
                return const Center(child: Text('No medicine found.'));
              }

              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final medicine = list[index];
                  return MedicineCard(medicineReminder: medicine);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
