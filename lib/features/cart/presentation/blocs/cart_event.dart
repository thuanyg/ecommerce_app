import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartProductEntity product;

  AddToCart(this.product);
}

class LoadMyCart extends CartEvent {}

class DecreaseCartProduct extends CartEvent {
  String productID;

  DecreaseCartProduct(this.productID);
}

class IncreaseCartProduct extends CartEvent {
  String productID;

  IncreaseCartProduct(this.productID);
}

class RemoveProductFromCart extends CartEvent {
  final String productId;

  RemoveProductFromCart(this.productId);
}

class RemoveAllProduct extends CartEvent {}

class LoadCart extends CartEvent {}
