import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';

abstract class BuyNowState {}

class BuyNowInitial extends BuyNowState {}

class BuyNowLoading extends BuyNowState {}

class OrderBuyNowCreated extends BuyNowState {
  Order order;

  OrderBuyNowCreated(this.order);
}

class BuyNowPriceState extends BuyNowState {
  final int subtotal;
  final int shippingCost;
  final int tax;
  final double totalPrice;

  BuyNowPriceState({
    required this.subtotal,
    required this.shippingCost,
    required this.tax,
    required this.totalPrice,
  });
}

class BuyNowError extends BuyNowState {
  final String message;

  BuyNowError(this.message);
}
