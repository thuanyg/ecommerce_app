// ------- Product by Category
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class ProductCategoryState {}

class ProductCategoryInitial extends ProductCategoryState {}

class ProductCategoryLoading extends ProductCategoryState {}

class ProductCategoryLoaded extends ProductCategoryState {
  final List<ProductEntity> products;
  ProductCategoryLoaded(this.products);
}

class ProductCategoryError extends ProductCategoryState {
  final String message;

  ProductCategoryError(this.message);
}
