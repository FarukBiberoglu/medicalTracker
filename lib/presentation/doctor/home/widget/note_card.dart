import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled19/data/models/note_to_self_model.dart';
import 'package:untitled19/presentation/doctor/home/cubit/home_cubit.dart';

class NoteCard extends StatelessWidget {
  final NoteToSelfModel noteToSelfModel;

  const NoteCard({Key? key, required this.noteToSelfModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasDate = noteToSelfModel.noteDate != null;
    final formattedDate = hasDate ? DateFormat('dd MMM yyyy').format(noteToSelfModel.noteDate!) : '';
    final formattedTime = hasDate ? DateFormat('HH:mm').format(noteToSelfModel.noteDate!) : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50,],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 48, 20), // sağ padding eklendi
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noteToSelfModel.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Alt başlık
                  Text(
                    noteToSelfModel.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Divider(color: Colors.blueGrey.shade100, thickness: 1),
                  const SizedBox(height: 12),

                  // Tarih ve saat satırı: tarih sola, saat sağa
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey.shade700,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled_outlined,
                            color: Colors.deepOrange,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formattedTime,
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
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  noteToSelfModel.isCompleted ? Icons.check_circle : Icons.more_vert,
                  color: noteToSelfModel.isCompleted ? Colors.green : Colors.grey,
                ),
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
                            ListTile(
                              leading: Icon(
                                noteToSelfModel.isCompleted
                                    ? Icons.check_circle_outline
                                    : Icons.check_circle,
                                color: noteToSelfModel.isCompleted ? Colors.grey : Colors.green,
                              ),
                              title: Text(
                                noteToSelfModel.isCompleted
                                    ? 'Uncompleted'
                                    : 'Completed',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                context.read<HomeCubit>().completeNote(noteToSelfModel);
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
                                context.read<HomeCubit>().deleteTask(noteToSelfModel);
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
