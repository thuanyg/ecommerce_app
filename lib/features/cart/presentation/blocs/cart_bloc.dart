import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_product_to_cart.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/get_cart.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/quantity_control.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/remove_control.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddProductToCartUseCase addProductToCart;
  final GetCartUseCase getCartUseCase;
  final QuantityControlUseCase quantityControlUseCase;
  final RemoveControlUseCase removeControlUseCase;

  CartBloc({
    required this.addProductToCart,
    required this.getCartUseCase,
    required this.quantityControlUseCase,
    required this.removeControlUseCase,
  }) : super(CartInitial()) {
    on<AddToCart>(_onAddProductToCart);
    on<LoadMyCart>(_onLoadMyCart);
    on<DecreaseCartProduct>(_decreaseCartProduct);
    on<IncreaseCartProduct>(_increaseCartProduct);
    on<RemoveProductFromCart>(_onRemoveProductMyCart);
    on<RemoveAllProduct>(_onRemoveAllMyCart);
  }

  FutureOr<void> _onLoadMyCart(
      LoadMyCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final products = await getCartUseCase();
      if (products.isNotEmpty) {
        emit(CartLoaded(products));
      } else {
        emit(CartEmpty());
      }
    } catch (error) {
      emit(CartError('Failed to load cart'));
    }
  }

  FutureOr<void> _onRemoveAllMyCart(
      RemoveAllProduct event, Emitter<CartState> emit) async {
    emit(CartLoading());
    await removeControlUseCase.removeAll();
    emit(CartEmpty());
  }

  FutureOr<void> _decreaseCartProduct(
      DecreaseCartProduct event, Emitter<CartState> emit) async {
    int updatedQuantity =
        await quantityControlUseCase.decrease(event.productID);

    final products = await getCartUseCase();
    int totalQuantity =
        products.fold(0, (sum, element) => sum + element.quantity);
    emit(CartTotalQuantity(totalQuantity));

    if (products.isNotEmpty) {
      emit(CartLoaded(products));
    } else {
      emit(CartEmpty());
    }
  }

  FutureOr<void> _increaseCartProduct(
      IncreaseCartProduct event, Emitter<CartState> emit) async {
    int updatedQuantity =
        await quantityControlUseCase.increase(event.productID);

    final products = await getCartUseCase();
    int totalQuantity =
        products.fold(0, (sum, element) => sum + element.quantity);
    emit(CartTotalQuantity(totalQuantity));
    emit(CartLoaded(products));
  }

  FutureOr<void> _onAddProductToCart(
      AddToCart event, Emitter<CartState> emit) async {
    try {
      // Thêm sản phẩm vào giỏ hàng
      await addProductToCart(event.product);
      // Sau khi thêm, lấy lại giỏ hàng mới
      final products = await getCartUseCase();
      emit(CartLoaded(products));
      int totalQuantity =
          products.fold(0, (sum, element) => sum + element.quantity);
      emit(CartTotalQuantity(totalQuantity));
    } catch (e) {
      emit(CartError('Failed to add product to cart'));
    }
  }

  FutureOr<void> _onRemoveProductMyCart(event, emit) async {
    try {
      emit(CartLoading());
      // Remove the product from the cart
      await removeControlUseCase.removeFromCart(event.productId);

      final products = await getCartUseCase();
      if (products.isNotEmpty) {
        emit(CartLoaded(products));
      } else {
        emit(CartEmpty());
      }
    } catch (e) {
      // Handle errors during product removal
      emit(CartError('Failed to remove product from cart'));
    }
  }

  int _calculateSubtotal(List<CartProductEntity> products) {
    double subtotal = products.fold(
        0, (sum, product) => sum + (product.price * product.quantity));
    return subtotal.ceil();
  }

  int _calculateShippingCost(int subtotal) {
    // For example, free shipping if the subtotal is over $50
    if (subtotal == 0) return 0;
    return (subtotal >= 50 ? 0 : 2).ceil();
  }

  int _calculateTax(int subtotal) {
    // 0.5% tax rate
    return (subtotal * 0.5 / 100).ceil();
  }

  CartPriceState getCartPriceState(List<CartProductEntity> products) {
    final subtotal = _calculateSubtotal(products);
    final shippingCost = _calculateShippingCost(subtotal);
    final tax = _calculateTax(subtotal);
    final totalPrice = subtotal + shippingCost + tax;

    return CartPriceState(
      subtotal: subtotal,
      shippingCost: shippingCost,
      tax: tax,
      totalPrice: totalPrice.toDouble(),
    );
  }
}
