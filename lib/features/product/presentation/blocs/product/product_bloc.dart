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
  int currentPage = 1;
  bool isLoadingMore = false;

  ProductBloc({this.fetchProducts, this.fetchProductByID})
      : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<RefreshProducts>(_onRefreshProducts);
  }

  Future<void> _onLoadProducts(event, emit) async {
    final currentState = state;
    isLoadingMore = true;
    if (!_hasReachedMax(currentState) && fetchProducts != null) {
      try {
        if (currentState is ProductInitial) {
          emit(ProductLoading());
          final products = await fetchProducts!(currentPage, event.limit);

          if (products.isEmpty) {
            emit(ProductError("Products empty."));
            return;
          }

          emit(ProductLoaded(
            products: products,
            hasReachedMax: false,
          ));
        } else if (currentState is ProductLoaded) {
          currentPage++;
          final products = await fetchProducts!(currentPage, event.limit);
          emit(products.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ProductLoaded(
                  products: currentState.products + products,
                  hasReachedMax: false,
                ));
        }
        isLoadingMore = false;
      } catch (e) {
        isLoadingMore = false;
        emit(ProductError(e.toString()));
      }
    }
  }

  bool _hasReachedMax(ProductState state) =>
      state is ProductLoaded && state.hasReachedMax;

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

  FutureOr<void> _onRefreshProducts(event, emit) async {
    currentPage = 1;
    try {
      emit(ProductLoading());

      final products = await fetchProducts!(currentPage, event.limit);

      if (products.isEmpty) {
        emit(ProductError("Products empty."));
        return;
      }

      emit(ProductLoaded(
        products: products,
        hasReachedMax: false,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
