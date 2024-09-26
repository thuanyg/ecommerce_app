import 'package:ecommerce_app/features/cart/data/models/product.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDataSource {
  Future<void> addToCart(CartProductModel product);

  Future<List<CartProductModel>> getCart();

  Future<int> updateQuantity(String productId, int quantity);

  Future<int> decreaseQuantity(String productId);

  Future<int> increaseQuantity(String productId);

  Future<void> removeFromCart(String productId);

  Future<void> removeAll();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartProductModel> cartBox;

  CartLocalDataSourceImpl(this.cartBox);

  @override
  Future<void> addToCart(CartProductModel product) async {
    final existingProduct = cartBox.get(product.id);
    if (existingProduct != null) {
      // Create a new product instance with updated quantity
      final updatedProduct = CartProductModel(
        id: existingProduct.id,
        name: existingProduct.name,
        price: existingProduct.price,
        imageUrl: existingProduct.imageUrl,
        quantity:
            existingProduct.quantity + product.quantity, // Update the quantity
      );

      // Store the updated product in the box
      await cartBox.put(updatedProduct.id, updatedProduct);
    } else {
      // If the product does not exist, add it to the cart
      await cartBox.put(product.id, product);
    }
  }

  @override
  Future<List<CartProductModel>> getCart() async {
    return cartBox.values.toList();
  }

  @override
  Future<int> updateQuantity(String productId, int quantity) async {
    final product = cartBox.get(productId);
    if (product != null) {
      // Create a new instance of CartProductModel with the updated quantity
      final updatedProduct = CartProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        imageUrl: product.imageUrl,
        quantity: quantity, // Update the quantity
      );
      // Store the updated product in the box
      await cartBox.put(productId, updatedProduct);
    }
    return quantity;
  }

  @override
  Future<int> decreaseQuantity(String productId) async {
    final product = cartBox.get(productId);
    if (product != null) {
      if (product.quantity == 1) {
        removeFromCart(productId);
        return 0;
      }
      // Create a new instance of CartProductModel with the updated quantity
      final updatedProduct = CartProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        imageUrl: product.imageUrl,
        quantity: product.quantity - 1, // Decreasing the quantity
      );
      // Store the updated product in the box
      await cartBox.put(productId, updatedProduct);
      return updatedProduct.quantity;
    }
    return 0;
  }

  @override
  Future<int> increaseQuantity(String productId) async {
    final product = cartBox.get(productId);
    if (product != null) {
      // Create a new instance of CartProductModel with the updated quantity
      final updatedProduct = CartProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        imageUrl: product.imageUrl,
        quantity: product.quantity + 1,
      );
      await cartBox.put(productId, updatedProduct);
      return updatedProduct.quantity;
    }
    return 0;
  }

  @override
  Future<void> removeFromCart(String productId) async {
    await cartBox.delete(productId);
  }

  @override
  Future<void> removeAll() async {
    await cartBox.clear();  // Xóa tất cả các mục trong giỏ hàng
  }
}
