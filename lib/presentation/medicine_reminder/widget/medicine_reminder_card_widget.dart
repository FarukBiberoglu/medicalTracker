import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/data/cache/hive_cache_service.dart';
import 'package:untitled19/data/service/service_locator.dart';

import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';

import 'package:untitled19/presentation/medicine_reminder/model/medicine_reminder_model.dart';



class MedicineCard extends StatelessWidget {
  final MedicineReminderModel medicineReminder;
  const MedicineCard({Key? key, required this.medicineReminder})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${medicineReminder.dose}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      medicineReminder.type.name,

                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                Expanded(
                  child: Text(
                    maxLines: 1,
                    medicineReminder.medicineName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      DateFormat('HH:mm').format(medicineReminder.medicineDate),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        medicineReminder.comments,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(medicineReminder.selectMedicine.asset),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: 12,
            right: 4,
            child: IconButton(
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
                      padding:  EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(
                              medicineReminder.isCompleted
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline_rounded,
                              color: medicineReminder.isCompleted ? Colors.grey : Colors.green,
                            ),
                            title: Text(
                              medicineReminder.isCompleted ? 'Uncompleted' : 'Completed',

                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              context.read<MedicineReminderCubit>().completeMedicine(medicineReminder);
                              Navigator.pop(context);
                            },
                          ),

                          ListTile(
                              leading: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                              title: const Text(
                                'Delete',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                context.read<MedicineReminderCubit>().deleteMedicine(medicineReminder);
                                Navigator.pop(context);
                              },
                            ),


                        ],
                      ),
                    );
                  },
                );
              },
              icon:  Icon(medicineReminder.isCompleted ? Icons.check_circle : Icons.more_vert,color: medicineReminder.isCompleted ? Colors.green : Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
