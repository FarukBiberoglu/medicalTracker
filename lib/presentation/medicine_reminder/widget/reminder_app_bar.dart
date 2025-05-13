import 'package:flutter/material.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';

class ReminderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReminderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 80,
      titleSpacing: 20,
      title: Row(
        children: [
          const Icon(
            Icons.notifications,
            color: AppColors.secondary,
            size: 40,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'My Reminders',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
            color: AppColors.secondary,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
