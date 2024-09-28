import 'package:ecommerce_app/core/components/bottom_sheet_add_to_cart.dart';
import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showBottomSheetAddToCart(BuildContext context,
    ProductEntity product) async {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return BottomSheetAddToCart(
        onAddToCart: (quantity) async {
          CartProductEntity productCart = CartProductEntity(
            id: product.id.toString(),
            name: product.title.toString(),
            price: product.price ?? 0,
            imageUrl: product.image.toString(),
            quantity: quantity,
          );
          BlocProvider.of<CartBloc>(context).add(AddToCart(productCart));
          DialogUtils.showLoadingDialog(context);
          await Future.delayed(const Duration(milliseconds: 500));
          DialogUtils.hide(context);
          Navigator.of(context).pop();
        },
      );
    },
  );
}