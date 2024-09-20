abstract class ProductEvent {}

class LoadProducts extends ProductEvent {
  final int limit;

  LoadProducts(this.limit);
}

class LoadProductByID extends ProductEvent {
  final int id;

  LoadProductByID(this.id);
}

class LoadProductsByCategory extends ProductEvent {
  final int limit;
  final String category;

  LoadProductsByCategory(this.limit, this.category);
}
