import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/presentation/chat/chat_view.dart';
import 'package:untitled19/presentation/medicine_reminder/view/medicine_reminder_view.dart';
import 'package:untitled19/presentation/profile/view/profile_view.dart';
import '../../appointment/view/appointment_view.dart';
import '../cubit/navigation_cubit.dart';
import '../cubit/navigation_cubit_state.dart';
import '../enum/main_navigation_enum.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  final List<MainNavigationEnum> _navItems = const [
    MainNavigationEnum.profile,
    MainNavigationEnum.home,
    MainNavigationEnum.appointment,
    MainNavigationEnum.chat,
  ];

  final List<IconData> _icons = const [
    Icons.supervisor_account_rounded,
    Icons.calendar_month_rounded,
    Icons.notification_important,
    Icons.chat_bubble_outline_rounded,
  ];

  final List<String> _labels = const [
    "Profile",
    "Appointments",
    "Reminder",
    "Chat",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          switch (state.selectedIndex) {
            case MainNavigationEnum.profile:
                return ProfileView();
            case MainNavigationEnum.home:
              return const MedicineView();
            case MainNavigationEnum.appointment:
              return const MedicineReminderView();
            case MainNavigationEnum.chat:
              return const ChatView();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                final selected = state.selectedIndex == _navItems[index];
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    context.read<NavigationCubit>().setSelectedIndex(_navItems[index]);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _icons[index],
                            size: selected ? 26 : 22,
                            color: selected ? AppColors.secondary : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: TextStyle(
                            fontSize: selected ? 13 : 12,
                            color: selected ? AppColors.secondary : Colors.grey,
                            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                          ),
                          child: Text(_labels[index]),
                        ),
                     
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 4,
                          width: selected ? 20 : 0,
                          decoration: BoxDecoration(
                            color: selected ? AppColors.secondary : Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
