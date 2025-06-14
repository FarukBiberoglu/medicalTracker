import 'package:flutter/material.dart';
import '../widget/appointment_body.dart';
import '../widget/appointment_welcome_section.dart';
import '../widget/float_button.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: AppointmentWelcomeAppBar(),
        extendBody: true,
        floatingActionButton:FloatButton() ,
        body: AppointmentBody(),
      ),
    );


  }
}
