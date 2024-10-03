import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';

class FetchProducts {
  final ProductRepository repository;

  FetchProducts(this.repository);

  Future<List<ProductEntity>> call(int page, int limit) async {
    return await repository.fetchProducts(page, limit);
  }
}