abstract class ProductCategoryEvent {}

class LoadProductsByCategory extends ProductCategoryEvent {
  final int limit;
  final String category;
  LoadProductsByCategory(this.limit, this.category);
}

class ResetProductCategory extends ProductCategoryEvent {}
