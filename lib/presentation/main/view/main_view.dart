import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/presentation/chat/chat_view.dart';
import 'package:untitled19/presentation/medicine_reminder/view/medicine_reminder_view.dart';
import '../../medicine/view/appointment_view.dart';
import '../cubit/navigation_cubit.dart';
import '../cubit/navigation_cubit_state.dart';
import '../enum/main_navigation_enum.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          switch (state.selectedIndex) {
            case MainNavigationEnum.home:
              return const MedicineView();
            case MainNavigationEnum.plan:
              return const MedicineView();
            case MainNavigationEnum.appointment:
              return const ChatView();
            case MainNavigationEnum.ayar:
              return const MedicineReminderView(); // Buraya istersen SettingsView() ekleyebilirsin
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Material(
            elevation: 0, // Gölgeyi kaldırmak için
            color: Colors.white,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              currentIndex: state.selectedIndex.index,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                context.read<NavigationCubit>().setSelectedIndex(MainNavigationEnum.values[index]);
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home, color: AppColors.primary),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.calendar_today_outlined),
                  activeIcon: Icon(Icons.calendar_today, color: AppColors.primary),
                  label: 'Plan',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.date_range),
                  activeIcon: Icon(Icons.date_range, color: AppColors.primary),
                  label: 'Appointments',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings, color: AppColors.primary),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
