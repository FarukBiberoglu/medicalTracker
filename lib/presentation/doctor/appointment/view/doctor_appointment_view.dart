import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled19/core/enum/doctor_appointment_tab_enum.dart';
import 'package:untitled19/core/extension/padding_extension.dart';
import 'package:untitled19/presentation/authentication/cubit/auth/auth_cubit.dart';
import 'package:untitled19/presentation/doctor/appointment/cubit/appointment_cubit.dart';
import 'package:untitled19/presentation/doctor/appointment/widget/all_request_tab_widget.dart';
import '../../../../core/widgets/tabbar/app_tabbar.dart';



class DoctorAppointmentView extends StatelessWidget {
  const DoctorAppointmentView({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorAppointmentCubit(
          context.read<AuthCubit>().state.user?.uid ?? ''
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(75),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children:  [
                          Icon(Icons.calendar_today_outlined, color: Colors.black87),
                          SizedBox(width: 12),
                          Text(
                            'My Appointments',
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ).symmetricPadding(vertical: 10),

                    ],
                  ).symmetricPadding(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AppTabbar(
                    selectedValue:
                    context.watch<DoctorAppointmentCubit>().state.currentTab,
                    onTap: context.read<DoctorAppointmentCubit>().setSelectedTab,
                    tabs:
                    DoctorAppointmentTabEnum.values
                        .map(
                          (e) => AppTabbarData(
                        title: e.displayValue,
                        value: e,
                      ),
                    )
                        .toList(),
                  ),
                  AppTabbarStackView(
                    selectedValue:
                    context.watch<DoctorAppointmentCubit>().state.currentTab,
                    tabs: [AllRequestTabWidget(), Container(), Container()],
                    tabEnums: DoctorAppointmentTabEnum.values,
                  ),

                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
