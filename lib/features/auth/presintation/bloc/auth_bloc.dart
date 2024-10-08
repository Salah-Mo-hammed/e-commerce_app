import 'dart:async';

import 'package:e_commerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:e_commerce_app/features/auth/presintation/bloc/auth_event.dart';
import 'package:e_commerce_app/features/auth/presintation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LogInUsecase logInUsecase;
  LogOutUsecase logOutUsecase;
  RegisterUsecase registerUsecase;
  AuthBloc(
      {required this.logInUsecase,
      required this.logOutUsecase,
      required this.registerUsecase})
      : super(const AuthStateLoading()) {
    on<AuthLogInEvent>(_onLogIn);
    on<AuthLogOutEvent>(_onLogOut);
    on<AuthRegisterEvent>(_onRegister);
  }

  FutureOr<void> _onLogIn(AuthLogInEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    final result = await logInUsecase.call(event.email, event.password);
    result.fold((failure) {
      emit(AuthStateException(exceptionMessage: failure.message));
    }, (userId) {
      emit(AuthStateSuccess(id: userId));
    });
  }

  FutureOr<void> _onLogOut(
      AuthLogOutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    final result = await logOutUsecase.call();
    result.fold((failure) {
      emit(AuthStateException(exceptionMessage: failure.message));
    }, (unit) {
      emit(const AuthStateLogOut());
    });
  }

  FutureOr<void> _onRegister(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    final result = await registerUsecase.call(event.email, event.password);
    result.fold((failure) {
      emit(AuthStateException(exceptionMessage: failure.message));
    }, (userId) {
      emit(AuthStateSuccess(id: userId));
    });
  }
}
