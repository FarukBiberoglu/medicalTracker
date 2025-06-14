import 'package:flutter/material.dart';
import 'package:untitled19/core/enum/appointment_state_enum.dart';

import '../constant/app_colors_constant.dart';

class AppointmentUtils {
  static Color getStateColor(AppointmentStateEnum state) {
    switch (state) {
      case AppointmentStateEnum.accept:
        return Colors.green.shade600;
      case AppointmentStateEnum.reject:
        return Colors.red.shade600;
      case AppointmentStateEnum.pending:
        return AppColors.grey;
    }
  }

  static IconData getStateIcon(AppointmentStateEnum state) {
    switch (state) {
      case AppointmentStateEnum.accept:
        return Icons.check_circle;
      case AppointmentStateEnum.reject:
        return Icons.cancel;
      case AppointmentStateEnum.pending:
        return Icons.hourglass_empty;
    }
  }
}
