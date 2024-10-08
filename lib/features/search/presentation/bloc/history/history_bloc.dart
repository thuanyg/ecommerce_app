import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/search/domain/usecase/history_search.dart';
import 'package:ecommerce_app/features/search/domain/usecase/search_product.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/history/history_event.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/history/history_state.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/search_event.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/search_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistorySearchUseCase historySearchUseCase;

  HistoryBloc(this.historySearchUseCase) : super(HistoryInitial()) {
    on<GetHistorySearch>(_getHistorySearch);
    on<SaveHistorySearch>(_saveHistorySearch);
    on<RemoveHistorySearch>(_removeHistorySearch);
    on<RemoveAllHistorySearch>(_removeAll);
  }

  FutureOr<void> _getHistorySearch(
      GetHistorySearch event, Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoading());
      final list = await historySearchUseCase.get();
      if (list != null && list.isNotEmpty) {
        list.sort(
            (a, b) => b.date.compareTo(a.date)); // Sort by date descending
        emit(HistoryLoaded(list: list));
      } else {
        emit(HistoryEmpty());
      }
    } on Exception catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  FutureOr<void> _saveHistorySearch(
      SaveHistorySearch event, Emitter<HistoryState> emit) async {
    try {
      await historySearchUseCase.save(event.query);
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  FutureOr<void> _removeHistorySearch(
      RemoveHistorySearch event, Emitter<HistoryState> emit) async {
    try {
      await historySearchUseCase.remove(event.query);
      final list = await historySearchUseCase.get();
      if (list != null && list.isNotEmpty) {
        list.sort(
            (a, b) => b.date.compareTo(a.date)); // Sort by date descending
        emit(HistoryLoaded(list: list));
      } else {
        emit(HistoryEmpty());
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  FutureOr<void> _removeAll(event, emit) async {
    try {
      await historySearchUseCase.removeAll();
      emit(HistoryLoaded(list: []));
      emit(HistoryEmpty());
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
