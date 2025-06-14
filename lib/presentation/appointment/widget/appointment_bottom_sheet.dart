import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/core/constant/app_string_constant.dart';
import 'package:untitled19/core/extension/padding_extension.dart';
import 'package:untitled19/core/widgets/sizedbox/directional_sizedbox.dart';
import 'package:untitled19/core/widgets/text_field/custom_textfield.dart';
import 'package:untitled19/data/repositories/appointment_repo.dart';
import 'package:untitled19/presentation/appointment/cubit/appointment_cubit.dart';

class AppointmentBottomSheet extends StatelessWidget {
  const AppointmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          DirectionalSizedBox(20),
          Text(
            AppStrings.addAppointment,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),

          DirectionalSizedBox(20),
          CustomTextFields(
            controller:
            context.read<AppointmentCubit>().doctorNameController,
            label: 'Doctor Name',
            icon: Icons.person,
            readOnly: true,
            onTap: () {
              showDoctorPickerBottomSheet(context);
            },
          ),
          SizedBox(height: 16),
          CustomTextFields(
            controller:
            context
                .read<AppointmentCubit>()
                .appointmentDateController,
            label: 'Appointment Date',
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

              context
                  .read<AppointmentCubit>()
                  .onChangedAppointmentDate(
                DateTime(
                  date.year,
                  date.month,
                  date.day,
                  time.hour,
                  time.minute,
                ),
              );
            },
          ),

          DirectionalSizedBox(30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: AppColors.primary,
                elevation: 4,
              ),
              onPressed: () {
                final cubit = context.read<AppointmentCubit>();
                if (cubit.doctorNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                  return;
                }

                cubit.addAppointment();
                Navigator.pop(context);
                cubit.resetValues();
              },
              child: Text(
                AppStrings.saveAppointmenst,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.White,
                ),
              ),
            ),
          ),
        ],
      ),
    ).onlyPadding(
      left: 20,
      right: 20,
      top: 20,
      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
    );
  }
}

void showDoctorPickerBottomSheet(BuildContext context) async {
  final repo = AppointmentRepo();
  final doctors = await repo.fetchDoctorNames();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              AppStrings.selectDoctor,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 12),

            // Liste
            Flexible(
              child:
              doctors.isEmpty
                  ? Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "No doctors found.",
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: doctors.length,
                separatorBuilder:
                    (_, __) => Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
                itemBuilder: (_, index) {
                  final doctor = doctors[index];
                  return ListTile(
                    leading: Icon(
                      Icons.person,
                      color: AppColors.primary,
                    ),
                    title: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              doctor.fullName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.black87,
                                letterSpacing: 0.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '(${doctor.specialization ?? ''})',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.blueGrey.shade400,
                                letterSpacing: 0.3,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      context
                          .read<AppointmentCubit>()
                          .onChangedDoctorName(doctor.fullName);
                      context.read<AppointmentCubit>().doctorId(
                        doctor.uid,
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}