import 'package:flutter/material.dart';
import 'package:untitled19/presentation/doctor/chat/view/doctor_chatt_view.dart';
import 'package:untitled19/presentation/doctor/appointment/view/doctor_appointment_view.dart';
import '../../../../core/router/app_router.dart';
import '../../../../data/service/service_locator.dart';
import 'go_to_chat_card.dart';
import 'note_to_self_dialog.dart';

class DailyPlan extends StatelessWidget {
  const DailyPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width ;

    return Center(
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: containerWidth,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: GoToCard(
                      buttonIcon: Icons.chat_bubble_outline,
                      title: "Chat",
                      subTitle: "conversation",
                      width: 300,
                      height: 100,
                      backgroundColor: Colors.blue.shade50,
                      onPressed: () {
                        getIt<AppRouter>().push(const DoctorChatView());
                      },
                    ),
                  ),
                  SizedBox(width:12,),
                  Expanded(
                    flex: 2,
                    child: GoToCard(
                      title: "Note",
                      subTitle: "Schedule ",
                      buttonIcon: Icons.edit_note,
                      width: double.infinity,
                      height: 100,
                      backgroundColor: Colors.green.shade50,
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: "NoteDialog",
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return const NoteToSelfDialog();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GoToCard(
                title: "Appointments",
                subTitle: "View and manage appointment",
                buttonIcon: Icons.calendar_month_outlined,
                width: double.infinity,
                height: 110,
                backgroundColor: Colors.orange.shade50,
                onPressed: () {
                  getIt<AppRouter>().push(const DoctorAppointmentView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
