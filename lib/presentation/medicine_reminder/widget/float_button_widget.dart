import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit_view.dart';
import 'package:untitled19/presentation/medicine_reminder/enum/type_enum.dart';
import '../../../core/constant/app_colors_constant.dart';

class MedicineFloatButton extends StatelessWidget {
  const MedicineFloatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Add Medicine',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  _buildTextField(
                    context,
                    controller: context.read<MedicineReminderCubit>().medicineNameController,
                    label: 'Medicine Name',
                    icon: Icons.person_outline,
                    onChanged: (value) => context.read<MedicineReminderCubit>().medicineName(value),
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    context,
                    controller: context.read<MedicineReminderCubit>().medicineDateController,
                    label: 'Medicine Date',
                    icon: Icons.calendar_today_outlined,
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 15)),
                      );
                      if (date == null || !context.mounted) return;

                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time == null || !context.mounted) return;

                      context.read<MedicineReminderCubit>().onChangedMedicineDate(DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      ));
                    },
                  ),
                BlocBuilder<MedicineReminderCubit, MedicineReminderCubitState>(
                  builder: (context, state) {
                    return DropdownButton<TypeEnum>(
                      value: state.selectedType,
                      hint: Text('Select Type'),
                      isExpanded: true,
                      onChanged: (TypeEnum? newValue) {
                        if (newValue != null) {
                          // Seçilen TypeEnum değerini cubite gönder
                          context.read<MedicineReminderCubit>().selectedType(newValue);
                        }
                      },
                      items: TypeEnum.values.map<DropdownMenuItem<TypeEnum>>((TypeEnum type) {
                        return DropdownMenuItem<TypeEnum>(
                          value: type,
                          child: Text(type.name),
                        );
                      }).toList(),
                    );
                  },
                ),
                  SizedBox(height: 16),
                  _buildTextField(
                    context,
                    controller: context.read<MedicineReminderCubit>().commentsController,
                    label: 'Comments',
                    icon: Icons.medical_services_outlined,
                    onChanged: (value) => context.read<MedicineReminderCubit>().comments(value),
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    context,
                    controller: context.read<MedicineReminderCubit>().doseController,
                    label: 'Doz',
                    icon: Icons.medical_services_outlined,
                    onChanged: (value) => context.read<MedicineReminderCubit>().dose(int.tryParse(value) ?? 1),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: AppColors.primary,
                        elevation: 4,
                      ),
                      onPressed: () {
                        final cubit = context.read<MedicineReminderCubit>();
                        if (cubit.medicineDateController.text.isEmpty ||
                            cubit.commentsController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill in all fields')),
                          );
                          return;
                        }
                        cubit.addMedicine();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save Appointment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        context.read<MedicineReminderCubit>().resetValues();
      },
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  Widget _buildTextField(
      BuildContext context, {
        required TextEditingController controller,
        required String label,
        required IconData icon,
        bool readOnly = false,
        VoidCallback? onTap,
        ValueChanged<String>? onChanged,
      }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black45),
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
