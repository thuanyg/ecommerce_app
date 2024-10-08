import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/features/product/data/models/product.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/search/data/datasource/search_datasource.dart';
import 'package:ecommerce_app/features/search/data/model/search_history.dart';
import 'package:hive/hive.dart';

class SearchDatasourceImpl extends SearchDatasource {
  final Dio dio;
  final Box<SearchHistory>? searchBox;

  SearchDatasourceImpl(this.dio, [this.searchBox]);

  @override
  Future<List<ProductModel>> searchProduct(
      String query, int page, int limit) async {
    try {
      Response response =
          await dio.get("$baseUrl/products?q=$query&_page=$page&_limit=$limit");

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
  Future<void> saveHistorySearch(String query) async {
    final existingQuery = searchBox?.get(query);
    if (existingQuery != null) {
      final updatedQuery = SearchHistory(
        date: DateTime.now(),
        query: existingQuery.query,
      );
      await searchBox?.put(updatedQuery.query, updatedQuery);
    } else {
      // If the product does not exist
      final updatedQuery = SearchHistory(
        date: DateTime.now(),
        query: query,
      );
      await searchBox?.put(query, updatedQuery);
    }
  }

  @override
  Future<List<SearchHistory>?> getHistorySearch() async {
    return searchBox?.values.toList();
  }

  @override
  Future<void> removeHistorySearch(String query) async {
    return await searchBox?.delete(query);
  }

  @override
  Future<void> removeAllHistorySearch() async {
    await searchBox?.clear();
  }
}
