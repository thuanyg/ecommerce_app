import 'package:ecommerce_app/features/cart/domain/entities/product.dart';

abstract class CartRepository {
  Future<void> addToCart(CartProductEntity product);

  Future<List<CartProductEntity>> getCart();

  Future<int> updateQuantity(String productId, int quantity);

  Future<int> decreaseQuantity(String productId);

  Future<int> increaseQuantity(String productId);

  Future<void> removeFromCart(String productId);

  Future<void> removeAll();
}
