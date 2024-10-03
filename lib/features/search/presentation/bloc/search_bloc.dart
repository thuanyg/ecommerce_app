import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/search/domain/usecase/search_product.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/search_event.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductUseCase searchProduct;
  int currentPage = 1;
  bool isLoadingMore = false;

  SearchBloc(this.searchProduct) : super(SearchInitial()) {
    on<SearchProduct>(_searchProduct);
    on<ResetSearchProduct>(_reset);
  }

  bool _hasReachedMax(SearchState state) =>
      state is SearchLoaded && state.hasReachedMax;

  FutureOr<void> _searchProduct(
      SearchProduct event, Emitter<SearchState> emit) async {
    final currentState = state;
    isLoadingMore = true;
    if (!_hasReachedMax(currentState)) {
      try {
        if (currentState is SearchInitial) {
          emit(SearchLoading());
          final products =
              await searchProduct.call(event.query, currentPage, event.limit);

          if (products.isEmpty) {
            emit(SearchEmpty());
            return;
          }
          emit(SearchLoaded(
            products: products,
            hasReachedMax: false,
          ) as SearchState);
        } else if (currentState is SearchLoaded) {
          currentPage++;
          final products =
              await searchProduct.call(event.query, currentPage, event.limit);
          emit(products.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : SearchLoaded(
                  products: currentState.products + products,
                  hasReachedMax: false,
                ));
        }
        isLoadingMore = false;
      } catch (e) {
        isLoadingMore = false;
        emit(SearchError(e.toString()));
      }
    }
  }

  FutureOr<void> _reset(ResetSearchProduct event, Emitter<SearchState> emit) {
    currentPage = 1;
    isLoadingMore = false;
    emit(SearchInitial());
  }
}
