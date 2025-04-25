import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/home/home_view.dart';
import 'package:untitled19/presentation/screens/auth/login_screen.dart';
import 'package:untitled19/router/app_router.dart';


import 'config/theme/app_theme.dart';
import 'data/service/service_locator.dart';
import 'logic/cubit/auth/auth_cubit.dart';
import 'logic/cubit/auth/auth_cubit_state.dart';

void main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
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
              return const HomeScreen();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}