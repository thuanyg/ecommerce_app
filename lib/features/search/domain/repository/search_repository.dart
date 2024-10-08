import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/search/data/model/search_history.dart';

abstract class SearchRepository {
  Future<List<ProductEntity>> searchProduct(String query, int page, int limit);
  Future<void> saveHistorySearch(String query);
  Future<List<SearchHistory>?> getHistorySearch();
  Future<void> removeHistorySearch(String query);
  Future<void> removeAllHistorySearch();
}