import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled19/core/enum/main_navigation_enum.dart';
import 'package:untitled19/presentation/chat/view/chat_view.dart';
import 'package:untitled19/presentation/doctor/settings/view/settings_view.dart';
import 'package:untitled19/presentation/medicine_reminder/view/medicine_reminder_view.dart';
import 'package:untitled19/presentation/profile/view/profile_view.dart';
import '../../appointment/view/appointment_view.dart';
import '../cubit/navigation_cubit.dart';
import '../cubit/navigation_cubit_state.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  final List<MainNavigationEnum> _navItems = const [
    MainNavigationEnum.profile,
    MainNavigationEnum.appointment,
    MainNavigationEnum.reminder,
    MainNavigationEnum.chat,
    MainNavigationEnum.settings,
  ];

  final List<IconData> _icons = const [
    Icons.supervisor_account_rounded,
    Icons.calendar_month_rounded,
    Icons.notification_important,
    Icons.chat_bubble_outline_rounded,
    Icons.settings,
  ];

  final List<String> _labels = const [
    "Profile",
    "Appointment",
    "Reminder",
    "Chat",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          switch (state.selectedIndex) {
            case MainNavigationEnum.profile:
              return ProfileView();
            case MainNavigationEnum.appointment:
              return const AppointmentView();
            case MainNavigationEnum.reminder:
              return const MedicineReminderView();
            case MainNavigationEnum.chat:
              return const ChatView();
            case MainNavigationEnum.settings:
              return SettingView();
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
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(_navItems.length, (index) {
                final selected = state.selectedIndex == _navItems[index];
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      context.read<NavigationCubit>().setSelectedIndex(_navItems[index]);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            _icons[index],
                            size: 24,
                            color: selected ? Colors.black : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _labels[index],
                          style: GoogleFonts.nunito(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: selected ?Colors.black : Colors.grey,
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
