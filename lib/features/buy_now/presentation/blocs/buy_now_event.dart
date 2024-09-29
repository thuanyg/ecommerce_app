import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class BuyNowEvent {}

class BuyNow extends BuyNowEvent {
  final Order order;

  BuyNow(this.order);
}


