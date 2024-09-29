import 'package:ecommerce_app/core/config/colors.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/features/cart/presentation/views/cart_screen.dart';
import 'package:ecommerce_app/features/category/category_screen.dart';
import 'package:ecommerce_app/features/home/page_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_history_page.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_event.dart';
import 'package:ecommerce_app/features/product/presentation/views/home_page.dart';
import 'package:ecommerce_app/features/user/presentation/views/profile_page.dart';
import 'package:ecommerce_app/features/favorite/presentation/views/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static String routeName = "/HomePage";
  final pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PageBloc(),
      child: Scaffold(
        body: BlocBuilder<PageBloc, int>(
          builder: (context, currentIndex) {
            final pageBloc = context.read<PageBloc>();
            return PageView(
              controller: pageBloc.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const MyHomeScreen(),
                CategoryScreen(),
                const CartScreen(),
                const WishlistScreen(),
                const ProfilePage(),
              ],
              onPageChanged: (index) {
                pageBloc.changePage(index);
              },
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<PageBloc, int>(
          builder: (context, currentIndex) {
            final pageBloc = context.read<PageBloc>();
            return BottomNavigationBar(
              iconSize: 24,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              currentIndex: currentIndex,
              onTap: (index) {
                if (currentIndex == index) {
                  switch (index) {
                    case 0:
                      print("Refresh Home");
                    case 1:
                      BlocProvider.of<ProductCategoryBloc>(context).add(
                        ResetProductCategory(),
                      );
                    case 2:
                      print("Refresh My Cart");
                    case 3:
                      print("Refresh Wishlist");
                  }
                } else {
                  pageBloc.changePage(index);
                }
              },
              unselectedItemColor: AppColors.disableColor,
              selectedItemColor: AppColors.enableColor,
              items: List.generate(
                navigationBarItems.length,
                (index) {
                  return BottomNavigationBarItem(
                    icon: Image.asset(navigationBarItems[index].image),
                    tooltip: navigationBarItems[index].label,
                    label: navigationBarItems[index].label,
                    activeIcon: Image.asset(
                      navigationBarItems[index].image,
                      color: AppColors.enableColor,
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
