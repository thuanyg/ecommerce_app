import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_by_category_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_products_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail/detail_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchProducts? fetchProducts;
  final FetchProductByID? fetchProductByID;
  List<ProductEntity> productsFavorite = [];

  ProductBloc({this.fetchProducts, this.fetchProductByID})
      : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
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

  Future<void> onLoadProductsFavorite(List<String> productIDs) async {
    productsFavorite.clear();
    try {
      // Duyệt qua danh sách productIDs và fetch từng sản phẩm
      for (String productID in productIDs) {
        final product = await fetchProductByID!(productID);
        if (product.id != null) {
          productsFavorite.add(product);
        }
      }
    } on Exception catch (e) {
      throw Exception("An error occurred while loading favorite products: $e");
    }
  }
}
