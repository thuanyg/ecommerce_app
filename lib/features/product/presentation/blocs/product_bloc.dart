import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_by_category_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_products_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchProducts? fetchProducts;
  final FetchProductsByCategory? fetchProductsByCategory;
  final FetchProductByID? fetchProductByID;

  // final CreateProduct createProduct;
  // final UpdateProduct updateProduct;
  // final DeleteProduct deleteProduct;

  ProductBloc(
      {this.fetchProducts, this.fetchProductsByCategory, this.fetchProductByID})
      : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<LoadProductByID>(_onLoadProductDetail);
  }

  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    if (fetchProducts != null) {
      emit(ProductLoading());
      try {
        final products = await fetchProducts!.call(event.limit);
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    }
  }

  Future<void> _onLoadProductsByCategory(
      LoadProductsByCategory event, emit) async {
    if (fetchProductsByCategory != null) {
      emit(ProductLoading());
      try {
        final products =
            await fetchProductsByCategory!.call(event.category, event.limit);
        products.isNotEmpty
            ? emit(ProductLoaded(products))
            : emit(ProductError("Product empty."));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    }
  }

  FutureOr<void> _onLoadProductDetail(
      LoadProductByID event, Emitter<ProductState> emit) async {
    if (fetchProductByID != null) {
      emit(ProductLoading());
      try {
        final product = await fetchProductByID!.call(event.id);
        final products = [product];
        product.title != ""
            ? emit(ProductLoaded(products))
            : emit(ProductError("Product empty."));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    }
  }
}
