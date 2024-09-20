import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_datasource.dart';
import 'package:ecommerce_app/features/product/data/models/product.dart';

class ProductDatasourceImpl extends ProductDataSource {
  final Dio dio;

  ProductDatasourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> fetchProducts(int limit) async {
    Response response =
        await dio.get("https://fakestoreapi.com/products?limit=$limit");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = response.data;
      final listProducts =
          jsonData.map((item) => ProductModel.fromJson(item)).toList();
      return listProducts;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<ProductModel>> fetchProductsByCategory(
      String category, int limit) async {
    try {
      Response response = await dio.get(
          "https://fakestoreapi.com/products/category/$category?limit=$limit");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final listProducts =
            data.map((item) => ProductModel.fromJson(item)).toList();
        return listProducts;
      }
      throw Exception();
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<ProductModel> fetchProduct(int id) async {
    try {
      Response response =
          await dio.get("https://fakestoreapi.com/products/$id");
      if (response.statusCode == 200) {
        final data = response.data;
        final ProductModel product = ProductModel.fromJson(data);
        return product;
      }
      throw Exception();
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
