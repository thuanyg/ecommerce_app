import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';

class FetchProductByID {
  final ProductRepository repository;

  FetchProductByID(this.repository);

  Future<ProductEntity> call(String id) async {
    return await repository.fetchProduct(id);
  }
}
