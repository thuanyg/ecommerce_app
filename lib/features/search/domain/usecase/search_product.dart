import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/search/domain/repository/search_repository.dart';

class SearchProductUseCase {
  final SearchRepository searchRepository;

  SearchProductUseCase(this.searchRepository);

  Future<List<ProductEntity>> call(String query, int page, int limit) async{
    return searchRepository.searchProduct(query, page, limit);
  }
}