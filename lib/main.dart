import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/authentication/cubit/auth/auth_cubit.dart';
import 'package:untitled19/presentation/authentication/cubit/auth/auth_cubit_state.dart';
import 'package:untitled19/presentation/authentication/login_screen.dart';
import 'package:untitled19/presentation/main/cubit/navigation_cubit.dart';
import 'package:untitled19/presentation/main/view/main_view.dart';
import 'package:untitled19/presentation/medicine/cubit/appointment_cubit.dart';
import 'package:untitled19/presentation/medicine_reminder/cubit/medicine_reminder_cubit.dart';
import 'package:untitled19/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'data/repositories/auth_repositories.dart';
import 'data/service/service_locator.dart';

void main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MedicineReminderCubit()),

          BlocProvider(create: (_) => RandevuCubit()),
          BlocProvider(create: (_) => NavigationCubit()),
          BlocProvider(create: (_) => AuthCubit(authRepository: AuthRepository())),
        ],
        child: MaterialApp(
          title: 'Messenger App',
          navigatorKey: getIt<AppRouter>().navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: BlocBuilder<AuthCubit, AuthState>(
            bloc: getIt<AuthCubit>(),
            builder: (context, state) {
              if (state.status == AuthStatus.initial) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (state.status == AuthStatus.authenticated) {
                return const MainView();
              }
              return const LoginView();
            },
          ),
        ),
      ),
    );
  }
}
