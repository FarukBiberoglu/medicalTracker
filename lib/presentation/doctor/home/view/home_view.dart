import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:untitled19/core/constant/app_string_constant.dart';
import 'package:untitled19/core/extension/padding_extension.dart';
import 'package:untitled19/core/widgets/sizedbox/directional_sizedbox.dart';
import 'package:untitled19/presentation/doctor/home/cubit/home_cubit.dart';
import 'package:untitled19/presentation/doctor/home/cubit/home_cubit_state.dart';
import 'package:untitled19/presentation/doctor/home/widget/daily_plan.dart';
import 'package:untitled19/presentation/doctor/home/widget/home_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (_, state) {
        return Scaffold(
          appBar: HomeHeader(),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            shape: BoxShape.circle,
                          ),
                        ),
                        DirectionalSizedBox(8),
                         Text(
                           AppStrings.todayAppointments,
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                DirectionalSizedBox(16),
                (state.randevuModel?.isEmpty ?? true)
                    ? SizedBox(
                      height: 160,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 1,
                        child: Center(
                          child: Text(
                            'Not Found Appointment',
                            style:  GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                    : SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.randevuModel!.length,
                        itemBuilder: (context, index) {
                          final data = state.randevuModel![index];
                          final user = data.userModel;

                          return Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              width: 260,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// User Info
                                  Row(
                                    children: [
                                      user?.imagePath != null
                                          ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          user!.imagePath!,
                                          width: 64,
                                          height: 64,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.person, size: 64, color: Colors.grey),
                                        ),
                                      )
                                          : const Icon(Icons.person, size: 64, color: Colors.grey),

                                      DirectionalSizedBox(14),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user?.fullName ?? 'Bilinmiyor',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF111827),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.medical_services_outlined,
                                                  size: 16,
                                                  color: Color(0xFF6B7280),
                                                ),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    user?.disease ?? 'Bilgi yok',
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                      color: const Color(0xFF6B7280),
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  Row(
                                    children: [
                                      const Icon(Icons.access_time_rounded,
                                          size: 18, color: Color(0xFF374151)),
                                      const SizedBox(width: 8),
                                      Text(
                                        DateFormat('HH:mm').format(data.appointmentDate),
                                        style: const TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF111827),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                 DirectionalSizedBox(30),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            shape: BoxShape.circle,
                          ),
                        ),
                        DirectionalSizedBox(8),

                        Text(
                          "My Daily Plan",
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                DirectionalSizedBox(15),
                DailyPlan(),
              ],
            ).symmetricPadding(horizontal: 20, vertical: 20),
          ),
        );
      },
    );
  }
}
