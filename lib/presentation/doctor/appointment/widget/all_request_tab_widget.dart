import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/doctor/appointment/cubit/appointment_cubit.dart';

import 'appointment_card_widget.dart';

class AllRequestTabWidget extends StatelessWidget {
  const AllRequestTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final randevuList = context.watch<DoctorAppointmentCubit>().state.randevuModel;

    if (randevuList == null || randevuList.isEmpty) {
      return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 200,),
        Center(
          child:Text('Not Found Appointment')
        ),
      ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: randevuList.length,
      itemBuilder: (context, index) {
        return AppointmentCard(
          appointmentModel: randevuList[index],
        );
      },
    );
  }
}
