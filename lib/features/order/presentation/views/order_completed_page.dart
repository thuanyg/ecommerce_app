import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCompletePage extends StatelessWidget {

  static String routeName = "/OrderCompletePage";

  const OrderCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green.shade300,
                  Colors.green.shade800,
                ],
              ),
            ),
          ),
          // Page content
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if(state is OrderCreateLoading){
                DialogUtils.showLoadingDialog(context);
              }
              if(state is OrderCreated){
                final priceCalculator = BlocProvider.of<CartBloc>(context)
                    .getCartPriceState(state.order.carts!);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Success Icon with shadow
                      const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 120,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 10.0,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Thank You Text
                      const Text(
                        'Order Confirmed!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Order Number with subtle shadow
                      Text(
                        'Order #${state.order.id}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Card with order summary details
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text(
                                'Total Amount',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '\$${priceCalculator.totalPrice}',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Continue Shopping Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                          backgroundColor: Colors.greenAccent.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 10,
                        ),
                        child: const Text(
                          'Continue Shopping',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // View Order Details Button with transparent background
                      TextButton(
                        onPressed: () {
                          // Navigate to Order History or Order Details page
                          Navigator.pushNamed(context, OrderDetailPage.routeName, arguments: state.order);
                        },
                        child: const Text(
                          'View Order Details',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

