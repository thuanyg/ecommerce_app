import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/search/data/model/search_history.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<SearchHistory> list;

  HistoryLoaded({required this.list});
}

class HistoryEmpty extends HistoryState {}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
