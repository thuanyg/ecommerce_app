import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductEntity> products;

  CartLoaded({required this.products});
}

class CartUpdated extends CartState {
  final int productCount; // Số lượng sản phẩm trong giỏ hàng

  CartUpdated(this.productCount);
}

class CartRemovedAll extends CartState {

}


class CartError extends CartState {
  final String error;

  CartError({required this.error});
}