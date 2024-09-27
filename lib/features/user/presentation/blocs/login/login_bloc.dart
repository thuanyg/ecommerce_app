import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/user/domain/usecase/login_usecase.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<PressLogin>(_login);
    on<RemoveLogin>((event, emit) => emit(LoginInitial()));
  }

  Future<void> _login(PressLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      String token = await loginUseCase(event.username, event.password);

      if (token.isNotEmpty) {
        emit(LoginSuccess(token));
        print(token);
      } else {
        emit(LoginError("Username or password incorrect."));
      }
    } catch (e) {
      emit(LoginError(
          "Login failed: ${e.toString()}")); // Emit error with exception message
    }
  }
}
