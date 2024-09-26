import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';

class RemoveControlUseCase {
  final CartRepository cartRepository;

  RemoveControlUseCase(this.cartRepository);

  Future<void> removeFromCart(String productId) async {
    return await cartRepository.removeFromCart(productId);
  }

  Future<void> removeAll() async {
    return await cartRepository.removeAll();
  }
}