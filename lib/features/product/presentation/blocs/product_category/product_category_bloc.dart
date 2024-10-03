import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_by_category_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final FetchProductsByCategory? fetchProductsByCategory;

  int currentPage = 1;

  ProductCategoryBloc(this.fetchProductsByCategory)
      : super(ProductCategoryInitial()) {
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<ResetProductCategory>((event, emit) => emit(ProductCategoryInitial()));
  }

  Future<void> _onLoadProductsByCategory(event, emit) async {
    final currentState = state;

    if (!_hasReachedMax(currentState) && fetchProductsByCategory != null) {
      try {
        if (currentState is ProductCategoryInitial) {
          emit(ProductCategoryLoading());

          final products = await fetchProductsByCategory!
              .call(event.category, currentPage, event.limit);

          if (products.isEmpty) {
            emit(ProductCategoryError("Products empty."));
            return;
          }

          emit(
            ProductCategoryLoaded(
              products: products,
              hasReachedMax: false,
            ),
          );
        } else if (currentState is ProductCategoryLoaded) {
          currentPage++;
          final products = await fetchProductsByCategory!
              .call(event.category, currentPage, event.limit);

          emit(
            products.isEmpty
                ? currentState.copyWith(hasReachedMax: true)
                : ProductCategoryLoaded(
                    products: currentState.products + products,
                    hasReachedMax: false,
                  ),
          );
        }
      } catch (e) {
        emit(ProductCategoryError(e.toString()));
      }
    }
  }

  bool _hasReachedMax(ProductCategoryState state) =>
      state is ProductCategoryLoaded && state.hasReachedMax;
}
