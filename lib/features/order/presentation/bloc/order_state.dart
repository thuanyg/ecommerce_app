

import 'package:ecommerce_app/features/order/data/model/order.dart';

abstract class OrderState {}

class OrderCreateInitial extends OrderState {}

class OrderCreateLoading extends OrderState {}

class OrderCreated extends OrderState {
  Order order;

  OrderCreated(this.order);
}

class OrderCreateFailed extends OrderState {}

// ---------------------------------------------------
// Trạng thái khi đang tải đơn hàng
class OrderLoading extends OrderState {}

// Trạng thái khi đơn hàng đã được tải
class OrderLoaded extends OrderState {
  final Order order;

  OrderLoaded(this.order);
}

// Trạng thái khi tải đơn hàng thất bại
class OrderLoadFailed extends OrderState {
  final String error;

  OrderLoadFailed(this.error);
}