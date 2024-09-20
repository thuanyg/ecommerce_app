import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class CartEvent {}


class AddToCart extends CartEvent {
  final ProductEntity product;

  AddToCart(this.product);
}

class LoadMyCart extends CartEvent {
}

class RemoveProductFromCart extends CartEvent {
  final int productId;

  RemoveProductFromCart(this.productId);
}

class RemoveAllProduct extends CartEvent {
}

class LoadCart extends CartEvent {}