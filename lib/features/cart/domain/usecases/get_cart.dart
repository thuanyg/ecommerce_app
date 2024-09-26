import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository cartRepository;

  GetCartUseCase(this.cartRepository);

  Future<List<CartProductEntity>> call() async {
    return await cartRepository.getCart();
  }
}
