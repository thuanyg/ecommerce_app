import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final bool hasReachedMax;

  ProductLoaded({required this.products, this.hasReachedMax = false});

  ProductLoaded copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}


