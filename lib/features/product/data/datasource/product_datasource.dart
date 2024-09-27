// product_datasource.dart
import 'package:ecommerce_app/features/product/data/models/product.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetchProducts(int limit);
  Future<List<ProductModel>> fetchProductsByCategory(String category, int limit);
  Future<ProductModel> fetchProduct(String id);
}