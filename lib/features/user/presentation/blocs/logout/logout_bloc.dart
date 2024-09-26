import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/user/domain/usecase/logout.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/logout/logout_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/logout/logout_state.dart';


class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogOutUseCase logOutUseCase;

  LogoutBloc({required this.logOutUseCase}) : super(LogoutInitial()) {
    on<PressLogout>(_logout);
  }

  Future<void> _logout(event, emit) async {
    emit(LogoutLoading());
    try {
      await logOutUseCase.call();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LoginError("Login failed: ${e.toString()}"));
    }
  }
}
