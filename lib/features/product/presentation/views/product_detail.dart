import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/config/colors.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/core/utils/functions.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail/detail_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail/detail_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ProductDetail extends StatefulWidget {
  static String routeName = "/ProductDetail";

  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      String id = ModalRoute.of(context)!.settings.arguments as String;

      BlocProvider.of<DetailBloc>(context).add(LoadProductByID(id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return Center(
              child: Lottie.asset(
                "assets/animations/loading.json",
                width: 90,
              ),
            );
          }

          if (state is ProductDetailLoadFailed) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is ProductDetailLoaded) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 260,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            "assets/images/img_detail_product.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 16),
                                        Text(
                                          state.product.title.toString(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 2,
                                        ),
                                        Text(
                                          "\$${state.product.price?.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0x74ABABAB),
                                      ),
                                      child: const Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.black12,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Choose the color",
                                style: TextStyle(
                                  color: Color(0xff939393),
                                ),
                              ),
                              const SizedBox(height: 3),
                              buildChooseColor(context),
                              const SizedBox(height: 10),
                              buildSeller(),
                              const SizedBox(height: 10),
                              const Text(
                                "Description of product",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                state.product.description.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 24,
                        child: ElevatedButton(
                          onPressed: () {
                            showBottomSheetAddToCart(context, state.product);
                          },
                          style: ButtonStyle(
                            backgroundColor: const WidgetStatePropertyAll(
                                AppColors.enableColor),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Add to cart",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 24,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: const WidgetStatePropertyAll(
                                Color(0xffF0F2F1),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              side: const WidgetStatePropertyAll(
                                BorderSide(
                                  color: Color(0xffD9D9D9),
                                ),
                              )),
                          child: const Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }

          return Center(
            child: Lottie.asset(
              "assets/animations/loading.png",
              width: 90,
            ),
          );
        },
      ),
    );
  }

  Widget buildSeller() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xffF0F2F1),
          ),
          bottom: BorderSide(
            color: Color(0xffF0F2F1),
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            child: Image.asset("assets/images/ic_apple.png"),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Mart",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "online 12 mins ago",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff939393),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
            child: OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                side: const MaterialStatePropertyAll(
                  BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                ),
              ),
              child: const Text("Follow"),
            ),
          )
        ],
      ),
    );
  }

  Row buildChooseColor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        5,
        (index) {
          return InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 5 - 18,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  color: colorsProduct[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: true,
      title: const Text("Details product"),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
            const Positioned(
              top: 8,
              right: 8,
              child: Badge(
                label: Text("1"),
                isLabelVisible: true,
              ),
            ),
          ],
        )
      ],
    );
  }
}
