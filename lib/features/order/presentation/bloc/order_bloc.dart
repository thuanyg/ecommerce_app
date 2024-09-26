import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/domain/usecase/create_order.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUseCase  createUseCase;

  OrderBloc(this.createUseCase) : super(OrderCreateInitial()) {
    on<CreateOrder>(createOrder);
  }

  FutureOr<void> createOrder(CreateOrder event, Emitter<OrderState> emit)  async {
    emit(OrderCreateLoading());
    try {
      Order order = await createUseCase(event.order);
      emit(OrderCreated(order));
    } on Exception catch (e) {
      rethrow;
    }
  }
}
