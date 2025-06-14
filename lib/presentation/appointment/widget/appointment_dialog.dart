import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/core/constant/app_string_constant.dart';
import 'package:untitled19/core/extension/padding_extension.dart';
import 'package:untitled19/core/utils/appointment_utils.dart';
import 'package:untitled19/core/widgets/sizedbox/directional_sizedbox.dart';
import 'package:untitled19/data/models/appointment_model.dart';

class AppointmentDialog extends StatelessWidget {
  const AppointmentDialog({super.key,required this.randevuModel});

  final AppointmentModel randevuModel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 150),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          DirectionalSizedBox(16),
          Center(
            child: Text(
              AppStrings.appointmentDetail,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 0.3,
              ),
            ),
          ),
          DirectionalSizedBox(24),

          // Doctor
          Row(
            children: [
              Icon(Icons.person_rounded, color: AppColors.primary, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  randevuModel.doctorName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),

          DirectionalSizedBox(20),

          // Date & Time
          Row(
            children: [
              Icon(Icons.calendar_today_rounded, size: 20, color: AppColors.primary),
              const SizedBox(width: 10),
              Text(
                DateFormat("dd.MM.yyyy").format(randevuModel.appointmentDate),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          DirectionalSizedBox(20),
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 20, color: AppColors.primary),
              const SizedBox(width: 10),
              Text(
                DateFormat("HH:mm").format(randevuModel.appointmentDate),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),

          DirectionalSizedBox(20),

          // Status
          Row(
            children: [
              Icon(
                AppointmentUtils.getStateIcon(randevuModel.appointmentStateEnum),
                color: AppointmentUtils.getStateColor(randevuModel.appointmentStateEnum),
                size: 22,
              ),
              DirectionalSizedBox(10),
              Text(
                randevuModel.appointmentStateEnum.displayName,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),

          DirectionalSizedBox(28),

          // Button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppStrings.close,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ],
      ).symmetricPadding(horizontal: 24, vertical: 24),
    );
  }
}
