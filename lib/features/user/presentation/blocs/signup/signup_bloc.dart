import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/domain/usecase/signup_usecase.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_state.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/signup/signup_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpUseCase signUpUseCase;

  SignupBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on<PressSignUp>(_signUp);
  }

  FutureOr<void> _signUp(PressSignUp event, Emitter<SignupState> emit) async {
    emit(SignUpLoading());
    try {
      User user = await signUpUseCase(event.user);
      emit(SignUpSuccess(user));
    } on Exception catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}
