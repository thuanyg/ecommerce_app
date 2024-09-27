import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/domain/usecase/create_order.dart';
import 'package:ecommerce_app/features/order/domain/usecase/history_order.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';
import 'package:flutter/material.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUseCase  createUseCase;
  final HistoryOrderUseCase historyOrderUseCase;

  OrderBloc(this.createUseCase, this.historyOrderUseCase) : super(OrderCreateInitial()) {
    on<CreateOrder>(createOrder);
    on<LoadHistoryOrder>(loadHistoryOrder);
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

  FutureOr<void> loadHistoryOrder(LoadHistoryOrder event, Emitter<OrderState> emit) async {
    emit(HistoryOrderLoading());
    try {
      List<Order> orders = await historyOrderUseCase.call(event.userID);
      if(orders.isEmpty){
        emit(HistoryOrderEmpty());
      } else {
        emit(HistoryOrderLoaded(orders));
      }
    } on Exception catch (e) {
      emit(HistoryOrderFailed("Failed to get orders."));
    }
  }
}
