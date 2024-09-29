import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/core/components/bottom_sheet_add_to_cart.dart';
import 'package:ecommerce_app/core/components/product_item.dart';
import 'package:ecommerce_app/core/components/slide_item.dart';
import 'package:ecommerce_app/core/config/colors.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/core/utils/functions.dart';
import 'package:ecommerce_app/core/utils/image_helper.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/home/page_bloc.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_products_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_state.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  static String routeName = "/HomePage";

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(LoadProducts(30));
    BlocProvider.of<CartBloc>(context).add(LoadMyCart());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: RefreshIndicator(
        color: AppColors.enableColor,
        elevation: 3,
        onRefresh: () async {
          BlocProvider.of<ProductBloc>(context).add(LoadProducts(30));
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                const SizedBox(height: 8),
                buildSlider(),
                const SizedBox(height: 8),
                buildTitleLabel(
                  label: "Categories",
                  onSeeAll: () {
                    context.read<ProductCategoryBloc>().add(
                          ResetProductCategory(),
                        );
                    context.read<PageBloc>().changePage(1);
                  },
                ),
                buildCategory(context),
                buildTitleLabel(label: "Latest Products", onSeeAll: () {}),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return Center(
                        child: Lottie.asset(
                          "assets/animations/loading.json",
                          width: 90,
                        ),
                      );
                    }
                    if (state is ProductError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    if (state is ProductLoaded) {
                      return ProductGrid(products: state.products);
                    }
                    return const Center(
                      child: Text("Something went wrong."),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildCategory(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          4,
          (index) {
            return buildCategoryItem(
              context: context,
              index: index,
              onTap: () {
                context.read<ProductCategoryBloc>().add(
                      LoadProductsByCategory(
                        30,
                        categories[index].name.toLowerCase(),
                      ),
                    );
                context.read<PageBloc>().changePage(1);
              },
            );
          },
        ).toList(),
      ),
    );
  }

  InkWell buildCategoryItem(
      {required BuildContext context,
      required int index,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: MediaQuery.of(context).size.width / 4 - 18,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFF4F5FD),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              categories[index].image,
              height: 30,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 3),
            Expanded(
              child: Text(
                categories[index].name,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildSlider() {
    return SizedBox(
      height: 148,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 15,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return SlideItem(
            onTap: () async {
              final Uri url = Uri.parse(
                  'https://cellphones.com.vn/thiet-bi-am-thanh/tai-nghe/headphones.html');
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          );
        },
        options: CarouselOptions(
          height: 148,
          initialPage: 0,
          autoPlay: true,
          enableInfiniteScroll: true,
          viewportFraction: 1,
          enlargeCenterPage: true,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.only(top: 36),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/images/ic_logo_quickmart.png"),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search_rounded, size: 28),
              onPressed: () {},
            ),
            const SizedBox(width: 6),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.enableColor, width: 2),
              ),
              child: ImageHelper.loadAssetImage(
                "assets/images/ic_avatar.jpg",
                radius: BorderRadius.circular(100),
                height: 36,
                width: 36,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget buildTitleLabel(
    {required String label, required VoidCallback onSeeAll}) {
  return Row(
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
          style: TextStyle(fontSize: 16, color: AppColors.enableColor),
        ),
      )
    ],
  );
}

@override
bool get wantKeepAlive => true;

class ProductGrid extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductGrid({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return ProductGridItem(
          product: products[index],
          onAddToCart: () {
            showBottomSheetAddToCart(context, products[index]);
          },
        );
      },
    );
  }
}
