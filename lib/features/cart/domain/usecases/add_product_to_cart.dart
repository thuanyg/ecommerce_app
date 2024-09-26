import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';

class AddProductToCartUseCase {
  final CartRepository cartRepository;

  AddProductToCartUseCase(this.cartRepository);

  Future<void> call(CartProductEntity product) async {
    return await cartRepository.addToCart(product);
  }
}
