import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/enum/category_enum.dart';
import 'package:untitled19/core/extension/padding_extension.dart';
import 'package:untitled19/data/models/appointment_model.dart';
import 'package:untitled19/presentation/appointment/cubit/appointment_cubit.dart';

class AppointmentCardStation extends StatelessWidget {
  const AppointmentCardStation({super.key,required this.randevuModel});
  final AppointmentModel randevuModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (randevuModel.categoryEnum ==
            CategoryEnum.upcoming) ...[
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
              context.read<AppointmentCubit>().completed(
                randevuModel,
              );
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
              context.read<AppointmentCubit>().canceled(
                randevuModel,
              );
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
            context.read<AppointmentCubit>().deleteRandevu(
              randevuModel,
            );
            Navigator.pop(context);
          },
        ),
      ],
    ).allPadding(24);
  }
}
