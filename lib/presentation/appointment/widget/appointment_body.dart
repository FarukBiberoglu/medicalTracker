import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/core/constant/app_string_constant.dart';
import 'package:untitled19/core/extension/padding_extension.dart';
import 'package:untitled19/core/widgets/sizedbox/directional_sizedbox.dart';
import 'package:untitled19/core/widgets/text_field/custom_search_field.dart';
import 'package:untitled19/presentation/appointment/cubit/appointment_cubit.dart';
import 'package:untitled19/presentation/appointment/cubit/appointment_cubit_state.dart';
import 'appointments_card_widget.dart';
import 'category_filed.dart';

class AppointmentBody extends StatelessWidget {
  const AppointmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppointmentCubit>();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchField(
            controller: cubit.searchController,
            hintText: 'Search appointment...',
            onChanged: cubit.onChangedSearchController,
          ).symmetricPadding(horizontal: 16),

          DirectionalSizedBox(5),
          const CategoryFiled(),

          Expanded(
            child: BlocBuilder<AppointmentCubit, AppointmentCubitState>(
              builder: (context, state) {
                final query = cubit.searchController.text.toLowerCase();

                final filteredAppointments =
                    state.randevuModel
                        .where(
                          (e) =>
                              e.categoryEnum == state.selectedCategory &&
                              e.doctorName.toLowerCase().contains(query),
                        )
                        .toList();

                if (filteredAppointments.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noAppointment,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),

                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: filteredAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = filteredAppointments[index];
                    return AppointmenstCard(randevuModel: appointment);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
