import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/core/enum/appointment_state_enum.dart';
import 'package:untitled19/core/widgets/sizedbox/directional_sizedbox.dart';
import 'package:untitled19/data/models/appointment_model.dart';
import 'package:untitled19/presentation/doctor/appointment/cubit/appointment_cubit.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointmentModel;

  const AppointmentCard({super.key, required this.appointmentModel});

  void showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 20,
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Indicator
                  Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  DirectionalSizedBox(10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: appointmentModel.userModel?.imagePath != null
                        ? Image.network(
                      appointmentModel.userModel!.imagePath!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox.shrink();
                      },
                    )
                        : SizedBox.shrink(),
                  ),
                  DirectionalSizedBox(10),
                  Text(
                    appointmentModel.userModel?.fullName ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                 DirectionalSizedBox(10),
                  _buildInfoRow(
                    Icons.location_on,
                    'Location',
                    appointmentModel.userModel?.location,
                  ),
                  _buildInfoRow(
                    Icons.healing,
                    'Disease',
                    appointmentModel.userModel?.disease,
                  ),
                  _buildInfoRow(
                    Icons.cake,
                    'Age',
                    appointmentModel.userModel?.age?.toString(),
                  ),
                  _buildInfoRow(
                    Icons.monitor_weight,
                    'Weight',
                    appointmentModel.userModel?.weight?.toString(),
                  ),
                  _buildInfoRow(
                    Icons.height,
                    'Height',
                    appointmentModel.userModel?.height?.toString(),
                  ),
                  _buildInfoRow(
                    Icons.bloodtype,
                    'Blood Type',
                    appointmentModel.userModel?.bloodType?.value ?? '-',
                  ),
                  _buildInfoRow(
                    Icons.wc,
                    'Gender',
                    appointmentModel.userModel?.gender?.name ?? '-',
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
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
      },
    );
  }
  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value ?? '-',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDetailsDialog(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(
            color: AppColors.grey.withValues(alpha: 0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: appointmentModel.userModel?.imagePath != null
                      ? Image.network(
                    appointmentModel.userModel!.imagePath!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox.shrink();
                    },
                  )
                      : SizedBox.shrink(),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointmentModel.userModel?.fullName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        appointmentModel.userModel?.disease ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (_) => _buildBottomSheet(context),
                    );
                  },
                  child: const Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
           SizedBox(height: 20,),
           Row(
             children: [
               Row(
                 children: [
                   Icon(Icons.calendar_today_rounded, size: 20, color: AppColors.primary),
                   const SizedBox(width: 10),
                   Text(
                     DateFormat("dd.MM.yyyy").format(appointmentModel.appointmentDate),
                     style: TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w500,
                       color: Colors.grey.shade800,
                     ),
                   ),
                 ],
               ),
               Spacer(),
               Row(
                 children: [
                   Icon(Icons.access_time_rounded, size: 20, color: AppColors.primary),
                   const SizedBox(width: 10),
                   Text(
                     DateFormat("HH:mm").format(appointmentModel.appointmentDate),
                     style: TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w500,
                       color: Colors.grey.shade800,
                     ),
                   ),
                 ],
               ),
             ],
           ),


            const SizedBox(height: 20),
            if (appointmentModel.appointmentStateEnum !=
                    AppointmentStateEnum.accept ||
                appointmentModel.appointmentStateEnum !=
                    AppointmentStateEnum.reject)
              Row(
                children: [
                  if (appointmentModel.appointmentStateEnum !=
                      AppointmentStateEnum.reject)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.read<DoctorAppointmentCubit>().changeAppointmentState(
                            appointmentModel.copyWith(
                              appointmentStateEnum: AppointmentStateEnum.reject,
                            ),
                          );
                        },
                        icon: Icon(Icons.close, size: 18, color: Colors.red.shade300),
                        label: Text(
                          "Reject",
                          style: TextStyle(
                            color: Colors.red.shade300,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: Colors.red.shade100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.red.shade50.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  if (appointmentModel.appointmentStateEnum !=
                          AppointmentStateEnum.accept &&
                      appointmentModel.appointmentStateEnum !=
                          AppointmentStateEnum.reject)
                    const SizedBox(width: 8),
                  if (appointmentModel.appointmentStateEnum !=
                      AppointmentStateEnum.accept)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.read<DoctorAppointmentCubit>().changeAppointmentState(
                            appointmentModel.copyWith(
                              appointmentStateEnum: AppointmentStateEnum.accept,
                            ),
                          );
                        },
                        icon: Icon(Icons.check, size: 18, color: Colors.green.shade400),
                        label: Text(
                          "Accept",
                          style: TextStyle(
                            color: Colors.green.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: Colors.green.shade100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.green.shade50.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            title: const Text(
              "Completed",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.cancel_outlined, color: Colors.red),
            title: const Text(
              "Canceled",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
