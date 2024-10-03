import 'package:ecommerce_app/features/product/data/models/product.dart';
import 'package:ecommerce_app/features/search/data/model/search_history.dart';

abstract class SearchDatasource {
  Future<List<ProductModel>> searchProduct(String query, int page, int limit);
  Future<void> saveHistorySearch(String query);
  Future<List<SearchHistory>?> getHistorySearch();
  Future<void> removeHistorySearch(String query);
}