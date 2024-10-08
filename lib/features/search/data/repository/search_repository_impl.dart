import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/search/data/datasource/search_datasource_impl.dart';
import 'package:ecommerce_app/features/search/data/model/search_history.dart';
import 'package:ecommerce_app/features/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {

  final SearchDatasourceImpl searchDatasource;

  SearchRepositoryImpl(this.searchDatasource);

  @override
  Future<List<ProductEntity>> searchProduct(String query, int page, int limit)async  {
    try {
      final productModels =
      await searchDatasource.searchProduct(query, page, limit);

      final List<ProductEntity> products =
      productModels.map((model) => model.toEntity()).toList();

      return products;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<SearchHistory>?> getHistorySearch() async {
    return await searchDatasource.getHistorySearch();
  }

  @override
  Future<void> removeHistorySearch(String query) async {
    return await searchDatasource.removeHistorySearch(query);
  }

  @override
  Future<void> saveHistorySearch(String query)  async{
    return await searchDatasource.saveHistorySearch(query);
  }

  @override
  Future<void> removeAllHistorySearch() async {
    return await searchDatasource.removeAllHistorySearch();
  }

}