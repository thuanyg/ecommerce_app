import 'package:ecommerce_app/core/components/bottom_sheet_add_to_cart.dart';
import 'package:ecommerce_app/core/components/checkout_dialog.dart';
import 'package:ecommerce_app/core/components/order_price_info.dart';
import 'package:ecommerce_app/core/config/colors.dart';
import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:ecommerce_app/features/cart/presentation/components/cart_item.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_completed_page.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/CartScreen";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(LoadMyCart());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "My Cart",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderCreated) {
            BlocProvider.of<CartBloc>(context).add(RemoveAllProduct());
            DialogUtils.hide(context);
            Navigator.pushReplacementNamed(
                context, OrderCompletePage.routeName);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return Center(
                  child: Lottie.asset(
                    "assets/animations/loading.json",
                    width: 100,
                  ),
                );
              }
              if (state is CartError) {
                return const Center(
                  child: Text("Something went wrong!!!. Please try again"),
                );
              }
              if (state is CartEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        size: size.width * 0.20,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      Text(
                        "Your cart is empty!",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                );
              }
              if (state is CartLoaded) {
                final priceCaculator = BlocProvider.of<CartBloc>(context)
                    .getCartPriceState(state.products);
                return Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Products",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.products.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CartItem(
                                  onRemove: () {
                                    String productId = state.products[index].id;
                                    BlocProvider.of<CartBloc>(context).add(
                                      RemoveProductFromCart(productId),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 247, 247, 247),
                                        content: Text(
                                          "Item removed!",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    );
                                  },
                                  cartItem: state.products[index],
                                  onIncrease: () {
                                    String productID = state.products[index].id;
                                    BlocProvider.of<CartBloc>(context).add(
                                      IncreaseCartProduct(productID),
                                    );
                                  },
                                  onDecrease: () {
                                    String productID = state.products[index].id;
                                    BlocProvider.of<CartBloc>(context).add(
                                      DecreaseCartProduct(productID),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                    ),
                    SizedBox(
                      height: size.height * 0.020,
                    ),
                    OrderPriceInfo(size: size, priceCalculate: priceCaculator),
                    SizedBox(
                      height: size.height * 0.030,
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.064,
                      child: ElevatedButton(
                        onPressed: checkout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.enableColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Checkout (\$${priceCaculator.totalPrice})",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }

              return const Center(
                child: Text("Something went wrong!!!. Please try again"),
              );
            },
          ),
        ),
      ),
    );
  }

  void checkout() {
    showDialog(
      context: context,
      builder: (context) {
        return CheckoutDialog(
          onCheckOut: ({
            required addressController,
            required nameController,
            required phoneController,
            required selectedPaymentMethod,
          }) {
            paymentCheckoutAction(
              nameController: nameController,
              addressController: addressController,
              phoneController: phoneController,
              paymentMethod: selectedPaymentMethod,
              context: context,
            );
          },
        );
      },
    );
  }
}

void paymentCheckoutAction({
  required TextEditingController nameController,
  required TextEditingController addressController,
  required TextEditingController phoneController,
  required String paymentMethod,
  required BuildContext context,
}) async {
  DialogUtils.showLoadingDialog(context);

  String? id = await StorageUtils.getValue(key: "userid");

  String name = nameController.text.trim();
  String address = addressController.text.trim();
  String phone = phoneController.text.trim();

  final carts = await BlocProvider.of<CartBloc>(context).getCartUseCase.call();

  Order order = Order(
    phone: phone,
    address: address,
    name: name,
    date: DateTime.now().toString(),
    paymentMethod: paymentMethod,
    status: true,
    userID: id,
    carts: carts,
  );

  BlocProvider.of<OrderBloc>(context).add(CreateOrder(order));
}
