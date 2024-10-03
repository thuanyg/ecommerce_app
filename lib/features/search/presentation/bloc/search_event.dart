abstract class SearchEvent {}

class SearchProduct extends SearchEvent {
  final int limit;
  final String query;

  SearchProduct(this.query, this.limit);
}
class ResetSearchProduct extends SearchEvent {
}
