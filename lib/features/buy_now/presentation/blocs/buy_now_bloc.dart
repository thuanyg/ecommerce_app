import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/buy_now/domain/usecases/buy_now.dart';
import 'package:ecommerce_app/features/buy_now/presentation/blocs/buy_now_event.dart';
import 'package:ecommerce_app/features/buy_now/presentation/blocs/buy_now_state.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';

class BuyNowBloc extends Bloc<BuyNowEvent, BuyNowState> {
  final BuyNowUseCase buyNowUseCase;

  BuyNowBloc(this.buyNowUseCase) : super(BuyNowInitial()) {
    on<BuyNow>(_buyNowProduct);
  }

  FutureOr<void> _buyNowProduct(BuyNow event, Emitter<BuyNowState> emit) async {
    emit(BuyNowLoading());
    try {
      Order order = await buyNowUseCase.call(event.order);
      if (order.id != null) {
        emit(OrderBuyNowCreated(order));
      } else {
        emit(BuyNowError("Error..."));
      }
    } on Exception catch (e) {
      emit(BuyNowError(e.toString()));
    }
  }
}
