import 'package:ecommerce_app/features/product/data/datasource/product_datasource_impl.dart';
import 'package:ecommerce_app/features/product/data/models/product.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDatasourceImpl dataSource;

  ProductRepositoryImpl({required this.dataSource});

  @override
  Future<void> createProduct(ProductEntity product) async {}

  @override
  Future<void> deleteProduct(int productId) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> fetchProducts(int page, int limit) async {
    try {
      // Fetch dữ liệu từ data source (trả về danh sách ProductModel)
      final List<ProductModel> productModels =
          await dataSource.fetchProducts(page, limit);

      // Ánh xạ danh sách ProductModel thành danh sách ProductEntity
      final List<ProductEntity> products =
          productModels.map((model) => model.toEntity()).toList();

      return products;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> updateProduct(ProductEntity product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> fetchProductsByCategory(
      String category, int page, int limit) async {
    try {
      final productModels =
          await dataSource.fetchProductsByCategory(category, page, limit);

      final List<ProductEntity> products =
          productModels.map((model) => model.toEntity()).toList();

      return products;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<ProductEntity> fetchProduct(String id) async {
    try {
      final productModel = await dataSource.fetchProduct(id);

      final ProductEntity product = productModel.toEntity();

      return product;
    } catch (e) {
      throw e.toString();
    }
  }
}
