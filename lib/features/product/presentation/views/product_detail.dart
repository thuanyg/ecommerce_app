import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_datasource.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_datasource_impl.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail_state.dart';
import 'package:ecommerce_app/features/product/presentation/components/back_prev.dart';
import 'package:ecommerce_app/features/product/presentation/components/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      int id = ModalRoute
          .of(context)!
          .settings
          .arguments as int;

      BlocProvider.of<DetailBloc>(context).add(LoadProductByID(id));
    });

    return Scaffold(
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              child: const Center(
                child: CircularProgressIndicator(),),);
          }

          if (state is ProductDetailLoaded) {
            return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation
                  .centerFloat,
              floatingActionButton: ElevatedButton(
                style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(
                      Size(MediaQuery
                          .of(context)
                          .size
                          .width * 0.85, 64),
                    ),
                    backgroundColor: const WidgetStatePropertyAll(
                        Color(0xff8E6CEF))),
                onPressed: () {
                  addProductToCart(context, state.product);
                },
                child: const Text(
                  "Add to cart",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 16),
                margin: const EdgeInsets.only(top: 64),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackPrevScreenWidget(),
                        FavoriteWidget(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 260,
                              child: ListView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 248,
                                    width: 161,
                                    decoration: BoxDecoration(
                                        color: const Color(0xfff4f4f4),
                                        border: Border.all(
                                            color: Colors.grey, width: .3)),
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(right: 12),
                                    child: Image.network(
                                      state.product.image.toString(),
                                      height: 248,
                                      width: 161,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Men's Harrington Jacket",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "\$100",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xff_8E_6C_EF)),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xfff4f4f4),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    const Text(
                                        "Size", style: TextStyle(fontSize: 16)),
                                    DropdownButton<String>(
                                      value: "S",
                                      underline: const SizedBox.shrink(),
                                      icon: Image.asset(
                                        "assets/images/ic_dropdown.png",
                                      ),
                                      items: <String>[
                                        "S",
                                        'M',
                                        'L',
                                        'XL',
                                        'XXL'
                                      ]
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xfff4f4f4),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    const Text(
                                        "Color",
                                        style: TextStyle(fontSize: 16)),
                                    DropdownButton<String>(
                                      value: "Red",
                                      underline: const SizedBox.shrink(),
                                      icon: Image.asset(
                                        "assets/images/ic_dropdown.png",
                                      ),
                                      items: <String>[
                                        "Red",
                                        'Green',
                                        'White',
                                        'Black'
                                      ]
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Built for life and made to last, this full-zip corduroy jacket is part of our Nike Life collection. The spacious fit gives you plenty of room to layer underneath, while the soft corduroy keeps it casual and timeless.",
                              style: TextStyle(
                                fontSize: 14, color: Color(0xff272727),
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Shipping & Returns",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Free standard shipping and free 60-day returns",
                              style: TextStyle(
                                fontSize: 14, color: Color(0xff272727),
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Reviews",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('No products available'));
        },
      ),
    );
  }

  int selectedQuantity = 1;

  Future<int?> showQuantityDialog(BuildContext context) async {
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          title: const Text('Select Quantity'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xfff4f4f4),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Size", style: TextStyle(fontSize: 16)),
                          DropdownButton<String>(
                            value: "S",
                            underline: const SizedBox.shrink(),
                            icon: Image.asset(
                              "assets/images/ic_dropdown.png",
                            ),
                            items: <String>["S", 'M', 'L', 'XL', 'XXL']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xfff4f4f4),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Color", style: TextStyle(fontSize: 16)),
                          DropdownButton<String>(
                            value: "Red",
                            underline: const SizedBox.shrink(),
                            icon: Image.asset(
                              "assets/images/ic_dropdown.png",
                            ),
                            items: <String>["Red", 'Green', 'White', 'Black']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (selectedQuantity > 1) {
                                selectedQuantity--;
                              }
                            });
                          },
                        ),
                        Text(
                          '$selectedQuantity',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              selectedQuantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedQuantity);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedQuantity);
              },
              child: const Text('Add to cart'),
            ),
          ],
        );
      },
    );
  }

  Future<void> addProductToCart(BuildContext context,
      ProductEntity products) async {
    int? quantity = await showQuantityDialog(context);
    if (quantity != null) {
      CartProductEntity product = CartProductEntity(
          id: products.id.toString(),
          name: products.title.toString(),
          price: products.price ?? 0,
          imageUrl: products.image.toString(),
          quantity: quantity);
      BlocProvider.of<CartBloc>(context).add(
        AddToCart(product),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add product to cart successfully.'),
        ),
      );
    }
  }
}
