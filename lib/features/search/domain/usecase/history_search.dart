
import 'package:ecommerce_app/features/search/data/model/search_history.dart';
import 'package:ecommerce_app/features/search/domain/repository/search_repository.dart';

class HistorySearchUseCase {
  final SearchRepository searchRepository;

  HistorySearchUseCase(this.searchRepository);

  Future<void> save(String query) async {
    return await searchRepository.saveHistorySearch(query);
  }

  Future<List<SearchHistory>?> get() async {
    return await searchRepository.getHistorySearch();
  }

  Future<void> remove(String query) async {
    return await searchRepository.removeHistorySearch(query);
  }

  Future<void> removeAll() async {
    return await searchRepository.removeAllHistorySearch();
  }
}