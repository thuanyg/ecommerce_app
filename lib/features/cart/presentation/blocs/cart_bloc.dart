import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_product_to_cart.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<ProductEntity> _cart = [];

  final AddProductToCartUseCase addProductToCart;

  CartBloc({required this.addProductToCart}) : super(CartInitial()) {
    on<AddToCart>(_onAddProductToCart);
    on<LoadMyCart>(_onLoadMyCart);
    on<RemoveAllProduct>(_onRemoveAllMyCart);
  }

  FutureOr<void> _onAddProductToCart(AddToCart event, Emitter<CartState> emit) async {
    emit(CartUpdated(_cart.length + 1));
    _cart.add(event.product);
  }

  FutureOr<void> _onLoadMyCart(LoadMyCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    emit(CartLoaded(products: _cart));
    if(_cart.isEmpty) emit(CartError(error: "Cart is empty"));
  }

  FutureOr<void> _onRemoveAllMyCart(RemoveAllProduct event, Emitter<CartState> emit) async {
    emit(CartLoading());
    _cart.clear();
    emit(CartLoaded(products: _cart));
    emit(CartUpdated(0));
    emit(CartRemovedAll());
  }
}
