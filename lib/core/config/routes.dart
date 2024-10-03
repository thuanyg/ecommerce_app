import 'package:ecommerce_app/features/cart/presentation/views/cart_screen.dart';
import 'package:ecommerce_app/features/home/home_page.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_completed_page.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_detail_page.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_history_page.dart';
import 'package:ecommerce_app/features/product/presentation/views/product_detail.dart';
import 'package:ecommerce_app/features/search/presentation/views/search_page.dart';
import 'package:ecommerce_app/features/splash/splash_page.dart';
import 'package:ecommerce_app/features/user/presentation/views/login_page.dart';
import 'package:ecommerce_app/features/user/presentation/views/profile_page.dart';
import 'package:ecommerce_app/features/user/presentation/views/signup_page.dart';
import 'package:ecommerce_app/features/user/presentation/views/your_profile_page.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.routeName: (_) => const LoginPage(),
    SignupPage.routeName: (_) => const SignupPage(),
    HomePage.routeName: (_) => HomePage(),
    ProfilePage.routeName: (_) => const ProfilePage(),
    YourProfilePage.routeName: (_) => const YourProfilePage(),
    SplashPage.routeName: (_) => const SplashPage(),
    ProductDetail.routeName: (_) => const ProductDetail(),
    OrderCompletePage.routeName: (_) => const OrderCompletePage(),
    CartScreen.routeName: (_) => const CartScreen(),
    OrderDetailPage.routeName: (_) => OrderDetailPage(),
    OrderHistoryPage.routeName: (_) => OrderHistoryPage(),
    SearchPage.routeName: (_) => SearchPage(),
  };
}
