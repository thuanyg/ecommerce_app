import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final FetchProductByID fetchProductByID;

  DetailBloc(
      {required this.fetchProductByID})
      : super(DetailInitial()) {
    on<LoadProductByID>(_onLoadProductDetail);
  }

  FutureOr<void> _onLoadProductDetail(
      LoadProductByID event, Emitter<DetailState> emit) async {
    if (fetchProductByID != null) {
      emit(ProductDetailLoading());
      try {
        final product = await fetchProductByID(event.id);
        emit(ProductDetailLoaded(product));
      } catch (e) {
        throw e.toString();
      }
    }
  }
}
