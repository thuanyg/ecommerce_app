abstract class ProductEvent {}

class LoadProducts extends ProductEvent {
  final int limit;

  LoadProducts(this.limit);
}

