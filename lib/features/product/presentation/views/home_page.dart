import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/core/components/product_item.dart';
import 'package:ecommerce_app/core/components/slide_item.dart';
import 'package:ecommerce_app/core/config/colors.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/core/utils/functions.dart';
import 'package:ecommerce_app/core/utils/image_helper.dart';
import 'package:ecommerce_app/features/home/page_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_state.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_event.dart';
import 'package:ecommerce_app/features/search/presentation/views/search_page.dart';
import 'package:ecommerce_app/features/user/presentation/views/your_profile_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  static String routeName = "/HomePage";

  @override
  State<MyHomeScreen> createState() => MyHomeScreenState();
}

class MyHomeScreenState extends State<MyHomeScreen>
    with AutomaticKeepAliveClientMixin {


  final _scrollController = ScrollController();

  late ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _scrollController.addListener(_onScroll);
    _productBloc.add(LoadProducts(fetchLimit));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0, // Vị trí cuộn
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onScroll() {
    // if(_productBloc.isLoadingMore) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll == currentScroll) {
      _productBloc.add(
        LoadProducts(fetchLimit),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: RefreshIndicator(
        color: AppColors.enableColor,
        onRefresh: () async {
          _productBloc.add(RefreshProducts(fetchLimit));
        },
        child: SingleChildScrollView(
          controller: _scrollController,
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
                    if (state is ProductLoading || state is ProductInitial) {
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
                      return ProductGrid(
                        state: state,
                        scrollController: _scrollController,
                      );
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
    final size = MediaQuery.of(context).size;
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
                child: Transform.scale(
                  scale: kIsWeb ? 1.5 : 1,
                  child: ImageHelper.loadAssetImage(
                    "assets/images/ic_logo_quickmart.png",
                  ),
                ),
              ),
            ),
            IconButton(
              style: const ButtonStyle(
                shape: WidgetStatePropertyAll(CircleBorder()),
              ),
              icon: const Icon(Icons.search_rounded, size: 28),
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
            ),
            const SizedBox(width: 6),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, YourProfilePage.routeName);
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.enableColor, width: 2),
                  shape: BoxShape.circle,
                ),
                child: ImageHelper.loadAssetImage(
                  "assets/images/ic_avatar.jpg",
                  radius: BorderRadius.circular(100),
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
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
  final ScrollController scrollController;
  final ProductLoaded state;
  const ProductGrid({
    super.key,
    required this.scrollController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientation == Orientation.landscape ? 6 : 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        if (index >= state.products.length) {
          return Container();
        }
        return ProductGridItem(
          product: state.products[index],
          onAddToCart: () {
            showBottomSheetAddToCart(context, state.products[index]);
          },
        );
      },
    );
  }
}


