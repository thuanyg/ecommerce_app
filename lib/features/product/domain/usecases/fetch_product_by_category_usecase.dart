import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';

class FetchProductsByCategory {
  final ProductRepository repository;

  FetchProductsByCategory(this.repository);

  Future<List<ProductEntity>> call(String category, int page, int limit) async {
    return await repository.fetchProductsByCategory(category, page, limit);
  }
}
