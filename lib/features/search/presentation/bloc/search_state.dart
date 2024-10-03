import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductEntity> products;
  final bool hasReachedMax;

  SearchLoaded({required this.products, this.hasReachedMax = false});

  SearchLoaded copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
  }) {
    return SearchLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
