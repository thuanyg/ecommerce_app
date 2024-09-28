import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_by_category_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final FetchProductsByCategory? fetchProductsByCategory;

  ProductCategoryBloc(this.fetchProductsByCategory)
      : super(ProductCategoryInitial()) {
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<ResetProductCategory>((event, emit) => emit(ProductCategoryInitial()));
  }

  Future<void> _onLoadProductsByCategory(
      LoadProductsByCategory event, emit) async {
    if (fetchProductsByCategory != null) {
      emit(ProductCategoryLoading());
      try {
        final products =
            await fetchProductsByCategory!.call(event.category, event.limit);
        products.isNotEmpty
            ? emit(ProductCategoryLoaded(products))
            : emit(ProductCategoryError("Product empty."));
      } catch (e) {
        emit(ProductCategoryError(e.toString()));
      }
    }
  }
}
