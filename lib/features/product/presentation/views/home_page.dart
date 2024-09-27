import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/features/cart/data/repository/cart_repository_impl.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/get_cart.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:ecommerce_app/features/cart/presentation/views/cart_screen.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_state.dart';
import 'package:ecommerce_app/features/product/presentation/components/category_item.dart';
import 'package:ecommerce_app/features/product/presentation/components/product_card.dart';
import 'package:ecommerce_app/features/product/presentation/views/category_page.dart';
import 'package:ecommerce_app/features/product/presentation/views/product_by_category.dart';
import 'package:ecommerce_app/features/product/presentation/views/product_detail.dart';
import 'package:ecommerce_app/features/user/presentation/views/your_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  static String routeName = "/HomePage";

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen>
    with AutomaticKeepAliveClientMixin {
  int selectedQuantity = 1; // Default quantity

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(LoadProducts(10));
    BlocProvider.of<CartBloc>(context).add(LoadMyCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        margin: const EdgeInsets.only(top: 64),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(context),
              const SizedBox(height: 24),
              buildSearchHeader(context),
              const SizedBox(height: 16),
              buildTitleLabel(
                  label: "Categories",
                  onSeeAll: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CategoryPage(),
                      ),
                    );
                  }),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryItemWidget(
                      categoryName: categories[index].name,
                      imageUrl: categories[index].image,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProductByCategory(),
                            settings: RouteSettings(
                              arguments: categories[index].name.toString(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              buildTitleLabel(label: "Top Selling", onSeeAll: () {}),
              SizedBox(
                height: 225,
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductLoaded) {
                      return ListView.builder(
                        itemCount: state.products.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ProductCardWidget(
                            name: state.products[index].title.toString(),
                            price: '${state.products[index].price}\$',
                            imageUrl: state.products[index].image.toString(),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ProductDetail(),
                                  settings: RouteSettings(
                                    arguments: state.products[index].id ?? 1,
                                  ),
                                ),
                              );
                            },
                            onAddToCart: () async {
                              await addProductToCart(context, state.products, index);
                            },
                          );
                        },
                      );
                    }
                    if (state is ProductError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text('No products available'));
                  },
                ),
              ),
              buildTitleLabel(label: "Newest Products", onSeeAll: () {}),
              SizedBox(
                height: 225,
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductLoaded) {
                      var products = state.products.reversed.toList();
                      return ListView.builder(
                        itemCount: products.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ProductCardWidget(
                            name: products[index].title.toString(),
                            price: '${products[index].price}\$',
                            imageUrl: products[index].image.toString(),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ProductDetail(),
                                  settings: RouteSettings(
                                    arguments: products[index].id ?? 1,
                                  ),
                                ),
                              );
                            },
                            onAddToCart: () async {
                              await addProductToCart(context, products, index);
                            },
                          );
                        },
                      );
                    }
                    if (state is ProductError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text('No products available'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addProductToCart(
      BuildContext context, List<ProductEntity> products, int index) async {
    int? quantity = await showQuantityDialog(context);
    if (quantity != null) {
      CartProductEntity product = CartProductEntity(
          id: products[index].id.toString(),
          name: products[index].title.toString(),
          price: products[index].price ?? 0,
          imageUrl: products[index].image.toString(),
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

  Widget buildTitleLabel(
      {required String label, required VoidCallback onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: const Text(
              "See All",
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Container buildSearchHeader(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color(0xffF4F4F4),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Image.asset("assets/images/ic_search.png"),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: const TextStyle(color: Color(0xff272727), fontSize: 14),
        ),
        style:
            const TextStyle(color: Color(0xff272727), fontSize: 15, height: 2),
        cursorHeight: 18,
      ),
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Navigator.of(context).pushNamed(YourProfilePage.routeName);
          },
          child: CircleAvatar(
            child: Image.asset(
              "assets/images/ic_avatar.png",
              height: 50,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xffF4F4F4),
          ),
          child: DropdownButton<String>(
            value: "All",
            dropdownColor: const Color(0xffF4F4F4),
            icon: Image.asset(
              "assets/images/ic_dropdown.png",
            ),
            items: <String>["All", 'Men', 'Woman', 'Kids', 'Older']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          ),
        ),
        InkWell(
          onTap:() {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            children: [
              Container(
                height: 43,
                width: 43,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Color(0xff8E6CEF),
                ),
                child: Image.asset("assets/images/ic_bag.png"),
              ),
              Positioned(
                top: 0,
                right: 2,
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded) {
                      int totalQuantity = state.products
                          .fold(0, (sum, element) => sum + element.quantity);
                      return Badge(
                        backgroundColor: Colors.red,
                        label: Text(totalQuantity.toString()),
                      );
                    }
                    if (state is CartTotalQuantity) {
                      return Badge(
                        backgroundColor: Colors.red,
                        label: Text(state.total.toString()),
                      );
                    }
                    // if (state is CartRemovedAll) {
                    //   return const SizedBox.shrink();
                    // }
                    return const SizedBox.shrink();
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<int?> showQuantityDialog(BuildContext context) async {
    selectedQuantity = 1;
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
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                DialogUtils.showLoadingDialog(context);
                await Future.delayed(const Duration(seconds: 1));
                DialogUtils.hide(context);

                Navigator.of(context).pop(selectedQuantity);
              },
              child: const Text('Add to cart'),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
