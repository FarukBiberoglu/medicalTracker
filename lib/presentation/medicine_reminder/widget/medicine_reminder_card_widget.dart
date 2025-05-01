import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/medicine_reminder_model.dart';

class MedicineCard extends StatelessWidget {
  final MedicineReminderModel medicine;

  const MedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık
              Center(
                child: Text(
                  medicine.medicineName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Grid yapısı için Wrap veya Table kullanılabilir
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _InfoBox(
                    icon: Icons.medication,
                    label: "Doz",
                    value: "${medicine.dose} ${medicine.type.name}",
                  ),
                  _InfoBox(
                    icon: Icons.calendar_today,
                    label: "Tarih",
                    value: DateFormat("dd.MM.yyyy").format(medicine.medicineDate),
                  ),
                  _InfoBox(
                    icon: Icons.access_time,
                    label: "Saat",
                    value: DateFormat("HH:mm").format(medicine.medicineDate),
                  ),
                  if (medicine.comments != null && medicine.comments!.isNotEmpty)
                    _InfoBox(
                      icon: Icons.note,
                      label: "Not",
                      value: medicine.comments!,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoBox({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.teal),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(fontSize: 14, color: Colors.teal.shade800),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.teal.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
