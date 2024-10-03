abstract class ProductEvent {}

class LoadProducts extends ProductEvent {
  final int limit;

  LoadProducts(this.limit);
}

class RefreshProducts extends ProductEvent {
  final int limit;

  RefreshProducts(this.limit);
}

