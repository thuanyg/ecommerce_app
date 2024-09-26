import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';

class QuantityControlUseCase {
  final CartRepository cartRepository;

  QuantityControlUseCase(this.cartRepository);

  Future<int> decrease(String productId) async {
    return await cartRepository.decreaseQuantity(productId);
  }

  Future<int> increase(String productId) async {
    return await cartRepository.increaseQuantity(productId);
  }
}
