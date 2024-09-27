import 'package:ecommerce_app/features/order/data/model/order.dart';

abstract class OrderEvent {}

class CreateOrder extends OrderEvent {
  Order order;

  CreateOrder(this.order);
}

class LoadOrderEvent extends OrderEvent {
  final String orderId;

  LoadOrderEvent(this.orderId);
}

class LoadHistoryOrder extends OrderEvent {
  String userID;

  LoadHistoryOrder(this.userID);
}
