import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit_state.dart';

import 'package:untitled19/core/enum/type_enum.dart';

class TypeSelectorField extends StatelessWidget {
  const TypeSelectorField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MedicineReminderCubit, MedicineReminderCubitState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      for (var type in TypeEnum.values) ...[
                        ListTile(
                          title: Text(
                            type.name,
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: state.selectedType == type ? FontWeight.w700 : FontWeight.w400,
                              color: state.selectedType == type ? AppColors.primary : Colors.black87,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            context.read<MedicineReminderCubit>().selectedType(type);
                          },
                        ),
                        if (type != TypeEnum.values.last)
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            color: Colors.grey.shade300,
                            indent: 16,
                            endIndent: 16,
                          ),
                      ],
                    ],
                  );
                },
              );
            },
            child: AbsorbPointer(
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Type",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.category_outlined, color: AppColors.primary),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: TextEditingController(
                  text: state.selectedType?.name ?? "",
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
