import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
import 'package:untitled19/presentation/authentication/cubit/auth/auth_cubit.dart';
import '../../../data/service/service_locator.dart';
import '../../../router/app_router.dart';
import '../../authentication/login_screen.dart';
import '../cubit/appointment_cubit.dart';
import '../cubit/appointment_cubit_state.dart';
import '../enum/category_enum.dart';
import '../widget/category_card_widget.dart';
import '../widget/float_button.dart';
import '../widget/randevu_card_widget.dart';

class MedicineView extends StatelessWidget {
  const MedicineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: const FloatButton(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, ${context.watch<AuthCubit>().state.user?.fullName ?? ''}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                      Text(
                        "Manage your appointment easily",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey.shade400,
                        ),
                      ),
                    ],
                  ),

                  IconButton(
                    icon: Icon(Icons.arrow_back_outlined, color : AppColors.grey),
                    onPressed: () async {
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) =>  AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 8,
                            backgroundColor: Colors.white,
                            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            title: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(Icons.arrow_back_outlined, color: AppColors.primary),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "Confirm Logout",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            content: Text(
                              "Are you sure you want to log out of your account?",
                              style: TextStyle(fontSize: 15, color: Colors.black54),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey[700],
                                ),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey[700],
                                ),
                                child: const Text("Log Out"),
                              ),
                            ],
                          ),

                      );

                      if (shouldLogout == true) {
                        await getIt<AuthCubit>().signOut();
                        getIt<AppRouter>().pushAndRemoveUntil(const LoginView());
                      }
                    },
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: CategoryEnum.values
                    .map((e) => CategoryCardWidget(category: e))
                    .toList(),
              ),
            ),

            const SizedBox(height: 8),

            // Randevu listesi
            Expanded(
              child: BlocBuilder<RandevuCubit, RandevuCubitState>(
                builder: (context, state) {
                  final randevus = state.randevuModel
                      .where((e) => e.categoryEnum == state.selectedCategory)
                      .toList();

                  if (randevus.isEmpty) {
                    return Center(
                      child: Text(
                        "No appointments found",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey.shade300,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: randevus.length,
                    itemBuilder: (context, index) {
                      final randevu = randevus[index];
                      return RandevuCard(randevuModel: randevu);
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


//VERİLERİ LOCALE KAYDET. GİR ÇIK YAPINCA RANDECULAR ORDA KALSIN