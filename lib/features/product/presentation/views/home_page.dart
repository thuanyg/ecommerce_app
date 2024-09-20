import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:ecommerce_app/features/cart/presentation/views/cart_page.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_datasource_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_products_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_state.dart';
import 'package:ecommerce_app/features/product/presentation/components/category_item.dart';
import 'package:ecommerce_app/features/product/presentation/components/product_card.dart';
import 'package:ecommerce_app/features/product/presentation/views/category_page.dart';
import 'package:ecommerce_app/features/product/presentation/views/product_by_category.dart';
import 'package:ecommerce_app/features/product/presentation/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(LoadProducts(50));
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
                height: 108,
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
                height: 310,
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductLoaded) {
                      return ListView.builder(
                        itemCount: 10,
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
                            onAddToCart: () {
                              BlocProvider.of<CartBloc>(context).add(
                                AddToCart(state.products[index]),
                              );
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
                height: 310,
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductLoaded) {
                      return ListView.builder(
                        itemCount: 10,
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
                            onAddToCart: () {
                              BlocProvider.of<CartBloc>(context).add(
                                AddToCart(state.products[index]),
                              );
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
        CircleAvatar(
          child: Image.asset(
            "assets/images/ic_avatar.png",
            height: 50,
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          height: 48,
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
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const MyCartPage())),
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            children: [
              Container(
                height: 48,
                width: 48,
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
                    if (state is CartInitial) {
                      return const SizedBox.shrink();
                    }
                    if (state is CartUpdated) {
                      return Badge(
                        backgroundColor: Colors.red,
                        label: Text(state.productCount.toString()),
                      );
                    }
                    if (state is CartLoaded) {
                      return Badge(
                        backgroundColor: Colors.red,
                        label: Text(state.products.length.toString()),
                      );
                    }
                    if (state is CartRemovedAll) {
                      return const SizedBox.shrink();
                    }
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
}
