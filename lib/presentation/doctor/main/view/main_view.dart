import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/presentation/chat/view/chat_view.dart';
import 'package:untitled19/presentation/doctor/home/view/home_view.dart';
import 'package:untitled19/presentation/doctor/main/cubit/doctor_main_cubit.dart';
import 'package:untitled19/presentation/doctor/main/cubit/doctor_main_cubit_state.dart';
import 'package:untitled19/presentation/doctor/settings/view/settings_view.dart';
import 'package:untitled19/presentation/doctor/appointment/view/doctor_appointment_view.dart';
import 'package:untitled19/presentation/profile/view/profile_view.dart';

import '../enum/doctor_main_navigation_enum.dart';

class DoctorMainView extends StatelessWidget {
  const DoctorMainView({super.key});

  final List<DoctorMainNavigationEnum> _navItems = const [
    DoctorMainNavigationEnum.home,
    DoctorMainNavigationEnum.profile,
    DoctorMainNavigationEnum.chat,
    DoctorMainNavigationEnum.settings,
  ];

  final List<IconData> _icons = const [
    Icons.home_rounded,
    Icons.calendar_month_rounded,
    Icons.chat_bubble_outline_rounded,
    Icons.settings_rounded,
  ];

  final List<String> _labels = const [
    "Home",
    "Appointment",
    "Chat",
    "Settings",                       // yeni etiket
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DoctorNavigationCubit, DoctorNavigationState>(
        builder: (context, state) {
          switch (state.selectedIndex) {
            case DoctorMainNavigationEnum.profile:
              return DoctorAppointmentView();
            case DoctorMainNavigationEnum.home:
              return const HomeView();
            case DoctorMainNavigationEnum.chat:
              return const ChatView();
            case DoctorMainNavigationEnum.settings:
              return  SettingView();  // Yeni eklendi
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<DoctorNavigationCubit, DoctorNavigationState>(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(_navItems.length, (index) {
              final selected = state.selectedIndex == _navItems[index];
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    context.read<DoctorNavigationCubit>().setSelectedIndex(_navItems[index]);
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
