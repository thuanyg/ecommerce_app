import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/domain/usecase/get_user.dart';
import 'package:ecommerce_app/features/user/domain/usecase/logout.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  final GetUserUseCase getUserUseCase;

  PersonalBloc(this.getUserUseCase)
      : super(PersonalInitial()) {
    on<PersonalLoadInformation>(loadInformation);
  }

  FutureOr<void> loadInformation(
      PersonalLoadInformation event, Emitter<PersonalState> emit) async {
    emit(PersonalLoading());
    try {
      User user = await getUserUseCase(event.id);
      emit(PersonalLoaded(user));
    } on Exception catch (e) {
      emit(PersonalError(e.toString()));
    }
  }
}
