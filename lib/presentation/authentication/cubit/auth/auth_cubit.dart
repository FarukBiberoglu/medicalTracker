import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled19/core/enum/role_enum.dart';
import '../../../../data/repositories/auth_repositories.dart';
import '../../../../data/service/service_locator.dart';
import 'auth_cubit_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User?>? authStateSubscription;

  AuthCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState()) {
    _init();
  }

  void _init() {
    emit(state.copyWith(status: AuthStatus.initial));

    authStateSubscription =
        _authRepository.authStateChanges.listen((user) async {
          if (user != null) {
            try {
              final userData = await _authRepository.getUserData(user.uid);
              emit(state.copyWith(
                status: AuthStatus.authenticated,
                user: userData,
              ));
            } catch (e) {
              emit(state.copyWith(status: AuthStatus.unauthenticated, error: e.toString()));
            }
          } else {
            emit(state.copyWith(
              status: AuthStatus.unauthenticated,
              user: null,
            ));
          }
        });
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final user = await _authRepository.signIn(
        email: email,
        password: password,
      );

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String fullName,
    required String phoneNumber,
    required String password,
    required RoleEnum role,
    String? specialization,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final user = await _authRepository.signUp(
        role: role,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        specialization: specialization,
      );

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      ));
    }
  }


  Future<void> signOut() async {
    try {
      print(getIt<AuthRepository>().currentUser?.uid ?? "asasa");
      await _authRepository.singOut();
      print(getIt<AuthRepository>().currentUser?.uid ?? "asasa");
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }
}