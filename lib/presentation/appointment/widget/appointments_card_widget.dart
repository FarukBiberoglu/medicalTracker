import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:untitled19/presentation/appointment/widget/appointment_card_station.dart';
import 'package:untitled19/presentation/appointment/widget/appointment_dialog.dart';
import '../../../core/widgets/sizedbox/directional_sizedbox.dart';
import '../../../data/models/appointment_model.dart';

class AppointmenstCard extends StatelessWidget {
  final AppointmentModel randevuModel;

  const AppointmenstCard({super.key, required this.randevuModel});
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AppointmentDialog(randevuModel: randevuModel),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row with Doctor name and More button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      randevuModel.doctorName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueGrey.shade900,
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.expand_more_rounded,
                          color: Colors.grey),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (_) {
                            return AppointmentCardStation(randevuModel: randevuModel);
                          },
                        );
                      },
                    ),
                  ],
                ),
                DirectionalSizedBox(4),
                // Specialty and Appointment State (Icon+Text)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      randevuModel.doktorModel?.specialization ??'',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    )


                  ],
                ),
                DirectionalSizedBox(16),
                Divider(color: Colors.blueGrey.shade100, thickness: 1),
                DirectionalSizedBox(12),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.blueAccent,
                      size: 22,
                    ),
                    DirectionalSizedBox(8),
                    Text(
                      DateFormat("dd.MM.yyyy")
                          .format(randevuModel.appointmentDate),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.access_time_filled_outlined,
                      color: Colors.deepOrange,
                      size: 22,
                    ),
                    DirectionalSizedBox(8),
                    Text(
                      DateFormat("HH:mm").format(randevuModel.appointmentDate),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey.shade800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
