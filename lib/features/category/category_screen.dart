import 'package:ecommerce_app/core/components/product_item.dart';
import 'package:ecommerce_app/core/config/colors.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/core/utils/functions.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_state.dart';
import 'package:ecommerce_app/features/product/presentation/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  static String routeName = "/CategoryScreen";

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin {
  String categorySelected = "";

  @override
  Widget build(BuildContext context) {
    final categoriesHomeScreen = Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: .2,
        shadowColor: AppColors.enableColor,
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16, // Adjusted for better spacing
            crossAxisSpacing: 16, // Added cross axis spacing
            childAspectRatio: 2.0, // Adjusted for square items
          ),
          itemBuilder: (context, index) {
            return buildCategoryItem(
              context: context,
              index: index,
              onTap: () {
                categorySelected = categories[index].name;
                BlocProvider.of<ProductCategoryBloc>(context).add(
                  LoadProductsByCategory(30, categorySelected.toLowerCase()),
                );
              },
            );
          },
        ),
      ),
    );
    return Scaffold(
      body: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
        builder: (context, state) {
          if (state is ProductCategoryInitial == false) {
            return buildProductByCategoryScreen(
              context: context,
              category: categorySelected,
            );
          } else {
            return categoriesHomeScreen;
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget buildProductByCategoryScreen({
  required BuildContext context,
  required String category,
}) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: AppColors.enableColor,
      elevation: 3,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          BlocProvider.of<ProductCategoryBloc>(context).add(
            ResetProductCategory(),
          );
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      title: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
        builder: (context, state) {
          if (state is ProductCategoryLoaded) {
            return Text(
              state.products[0].category.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          } else {
            return const Text(
              "Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }
        },
      ),
    ),
    body: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
      builder: (context, state) {
        if (state is ProductCategoryLoading) {
          return Center(
            child: Lottie.asset(
              "assets/animations/loading.json",
              width: 90,
            ),
          );
        }

        if (state is ProductCategoryError) {
          final size = MediaQuery.of(context).size;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.category_outlined,
                  size: size.width * 0.20,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Text(
                  "The products of $category is empty!",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16
                  ),
                )
              ],
            ),
          );
        }

        if (state is ProductCategoryLoaded) {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two items per row
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return ProductGridItem(
                product: state.products[index],
                onAddToCart: () {
                  showBottomSheetAddToCart(context, state.products[index]);
                },
              );
            },
          );
        }

        return const Center(
          child: Text("error"),
        );
      },
    ),
  );
}
