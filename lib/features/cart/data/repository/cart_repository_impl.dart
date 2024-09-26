import 'package:ecommerce_app/features/cart/data/datasource/cart_local_datasource.dart';
import 'package:ecommerce_app/features/cart/data/models/product.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl(this.localDataSource);

  @override
  Future<void> addToCart(CartProductEntity product) {
    return localDataSource.addToCart(CartProductModel.fromEntity(product));
  }

  @override
  Future<List<CartProductEntity>> getCart() async {
    final carts = await localDataSource.getCart();
    return carts.map((e) => e.toEntity()).toList();
  }

  @override
  Future<int> updateQuantity(String productId, int quantity) async {
    return await localDataSource.updateQuantity(productId, quantity);
  }

  @override
  Future<void> removeFromCart(String productId) async {
    return await localDataSource.removeFromCart(productId);
  }

  @override
  Future<int> decreaseQuantity(String productId) async {
    return await localDataSource.decreaseQuantity(productId);
  }

  @override
  Future<int> increaseQuantity(String productId) async {
    return localDataSource.increaseQuantity(productId);
  }

  @override
  Future<void> removeAll() async {
    await localDataSource.removeAll();
  }
}
