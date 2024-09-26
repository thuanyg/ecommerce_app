import 'package:ecommerce_app/features/cart/domain/entities/product.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartTotalQuantity extends CartState {
  int total;

  CartTotalQuantity(this.total);
}

class CartLoading extends CartState {}

class CartProductIncreased extends CartState {}

class CartProductDecrease extends CartState {}

class CartPriceState extends CartState {
  final int subtotal;
  final int shippingCost;
  final int tax;
  final double totalPrice;

  CartPriceState({
    required this.subtotal,
    required this.shippingCost,
    required this.tax,
    required this.totalPrice,
  });
}

class CartLoaded extends CartState {
  final List<CartProductEntity> products;

  CartLoaded(this.products);
}

class CartEmpty extends CartState {}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
