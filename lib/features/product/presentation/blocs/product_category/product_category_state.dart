// ------- Product by Category
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class ProductCategoryState {}

class ProductCategoryInitial extends ProductCategoryState {}

class ProductCategoryLoading extends ProductCategoryState {}

class ProductCategoryLoaded extends ProductCategoryState {
  final List<ProductEntity> products;
  final bool hasReachedMax;
  ProductCategoryLoaded({required this.products, this.hasReachedMax = false});

  ProductCategoryLoaded copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
  }) {
    return ProductCategoryLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ProductCategoryError extends ProductCategoryState {
  final String message;

  ProductCategoryError(this.message);
}
