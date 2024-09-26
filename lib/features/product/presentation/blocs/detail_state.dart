import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class DetailState {}
class DetailInitial extends DetailState {}

class ProductDetailLoading extends DetailState {}

class ProductDetailLoaded extends DetailState {
  final ProductEntity product;
  ProductDetailLoaded(this.product);
}