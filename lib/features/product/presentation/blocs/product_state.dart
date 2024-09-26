import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class ProductState {}
class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductDetailLoading extends ProductState {}

class ProductDetailLoaded extends ProductState {
  final ProductEntity product;
  ProductDetailLoaded(this.product);
}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}