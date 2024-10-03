import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> fetchProducts(int page, int limit);
  Future<ProductEntity> fetchProduct(String id);
  Future<List<ProductEntity>> fetchProductsByCategory(String category, int page, int limit);
  Future<void> createProduct(ProductEntity product);
  Future<void> updateProduct(ProductEntity product);
  Future<void> deleteProduct(int productId);
}