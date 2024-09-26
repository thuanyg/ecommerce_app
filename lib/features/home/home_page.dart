import 'package:ecommerce_app/features/cart/presentation/views/cart_screen.dart';
import 'package:ecommerce_app/features/home/page_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_history_page.dart';
import 'package:ecommerce_app/features/product/presentation/views/home_page.dart';
import 'package:ecommerce_app/features/user/presentation/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static String routeName = "/HomePage";
  final pageController = PageController(initialPage: 0);

  int currentIndex = 0;

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
                const CartScreen(),
                OrderHistoryPage(),
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
              iconSize: 26,
              backgroundColor: Colors.white70,
              type: BottomNavigationBarType.fixed,
              elevation: 10,
              showUnselectedLabels: true,
              currentIndex: currentIndex,
              onTap: (index) {
                pageBloc.changePage(index);
              },
              unselectedItemColor: Colors.black54,
              selectedItemColor: Colors.deepOrange,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt),
                  label: 'Order',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
