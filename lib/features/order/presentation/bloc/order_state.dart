

import 'package:ecommerce_app/features/order/data/model/order.dart';

abstract class OrderState {}

class OrderCreateInitial extends OrderState {}

class OrderCreateLoading extends OrderState {}

class OrderCreated extends OrderState {
  Order order;

  OrderCreated(this.order);
}

class OrderCreateFailed extends OrderState {}

// --------------------------------------------------
class OrderLoading extends OrderState {}

// Trạng thái khi đơn hàng đã được tải
class OrderLoaded extends OrderState {
  final Order order;

  OrderLoaded(this.order);
}

class OrderLoadFailed extends OrderState {
  final String error;

  OrderLoadFailed(this.error);
}

class HistoryOrderInitial extends OrderState {}

class HistoryOrderLoading extends OrderState {}

class HistoryOrderLoaded extends OrderState {
  List<Order> orders;

  HistoryOrderLoaded(this.orders);
}

class HistoryOrderFailed extends OrderState {
  String error;
  HistoryOrderFailed(this.error);
}
class HistoryOrderEmpty extends OrderState {}