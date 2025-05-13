import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../data/cache/hive_cache_service.dart';
import '../../../data/service/service_locator.dart';
import '../cubit/appointment_cubit.dart';
import '../enum/category_enum.dart';
import '../model/appointment_model.dart';

class AppointmenstCard extends StatelessWidget {
  final AppointmentModel randevuModel;

  const AppointmenstCard({super.key, required this.randevuModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              color: Colors.blueGrey.withOpacity(0.1),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status badge
                  const SizedBox(height: 8),
                  // Doctor Name
                  Text(
                    randevuModel.doctorName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Specialty
                  Text(
                    randevuModel.specialty,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey.shade500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.blueGrey.shade100, thickness: 1),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.blueAccent,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat("dd.MM.yyyy").format(randevuModel.appointmentDate),
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
                      const SizedBox(width: 8),
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
            // More button
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.expand_more_rounded, color: Colors.grey),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (randevuModel.categoryEnum == CategoryEnum.upcoming) ...[
                              ListTile(
                                leading: const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                ),
                                title: const Text(
                                  'Completed',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  context.read<AppointmentCubit>().completed(randevuModel);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.red,
                                ),
                                title: const Text(
                                  'Canceled',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  context.read<AppointmentCubit>().canceled(randevuModel);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                            ListTile(
                              leading: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                              title: const Text(
                                'Delete',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                context.read<AppointmentCubit>().deleteRandevu(randevuModel);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
