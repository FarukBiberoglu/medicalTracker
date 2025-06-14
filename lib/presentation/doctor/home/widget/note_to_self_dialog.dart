import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/presentation/doctor/home/cubit/home_cubit.dart';
import 'package:untitled19/presentation/doctor/home/cubit/home_cubit_state.dart';
import 'package:untitled19/presentation/doctor/home/widget/note_card.dart';

class NoteToSelfDialog extends StatelessWidget {
  const NoteToSelfDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note To Self"),
      ),
      body: BlocBuilder<HomeCubit, HomeCubitState>(
        builder: (context, state) {
          if (state.notes.isEmpty) {
            return const Center(
              child: Text(
                "No notes yet.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: NoteCard(noteToSelfModel: note),
                );
              },
            ),
          );

        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showNoteDialog(context, cubit),
        label:  Text("Add Note",style: TextStyle(
          color: Colors.white
        ),),
        icon: const Icon(Icons.add,color: Colors.white,),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}

void showNoteDialog(BuildContext context, HomeCubit cubit) {
  DateTime? selectedDateTime;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Başlık
                    Row(
                      children: [
                        Icon(Icons.note_add_outlined, color: AppColors.primary, size: 28),
                        const SizedBox(width: 8),
                        const Text(
                          'Add New Note',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    /// Başlık input
                    _buildModernTextField(
                      controller: cubit.titleController,
                      label: 'Title',
                      icon: Icons.title,
                      onChanged: cubit.titleField,
                    ),

                    const SizedBox(height: 16),

                    /// Alt başlık input
                    _buildModernTextField(
                      controller: cubit.subtitleController,
                      label: 'Subtitle',
                      icon: Icons.notes,
                      onChanged: cubit.subtitle,
                    ),

                    const SizedBox(height: 16),

                    /// Tarih-Saat Seçimi
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date == null) return;

                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time == null) return;

                        setState(() {
                          selectedDateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                        });

                        cubit.onChangedTaskDate(selectedDateTime!);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, color: AppColors.primary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                selectedDateTime != null
                                    ? DateFormat('dd MMM yyyy - HH:mm').format(selectedDateTime!)
                                    : 'Select Date & Time',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color:  selectedDateTime != null ? Colors.black : AppColors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Butonlar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            cubit.resetValues();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          ),
                          onPressed: () {
                            if (cubit.titleController.text.trim().isEmpty ||
                                cubit.subtitleController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Lütfen tüm alanları doldurun')),
                              );
                              return;
                            }
                            if (selectedDateTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Tarih ve saat seçimi yapılmadı')),
                              );
                              return;
                            }

                            cubit.addNotes();
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: const Text(
                            'Add',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}



Widget _buildModernTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required Function(String) onChanged,
}) {
  return TextField(
    controller: controller,

    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: AppColors.grey

      ),
      prefixIcon: Icon(icon, color: AppColors.primary),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    ),
  );
}



