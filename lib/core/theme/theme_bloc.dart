import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/theme/theme_event.dart';
import 'package:ecommerce_app/core/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.lightTheme){
   on<ToggleTheme>(_toggleTheme);
  }

  FutureOr<void> _toggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    if (state == ThemeState.lightTheme) {
      emit(ThemeState.darkTheme);
    } else {
      emit(ThemeState.lightTheme);
    }
  }
}