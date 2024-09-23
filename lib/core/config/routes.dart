import 'package:ecommerce_app/features/product/presentation/views/home_page.dart';
import 'package:ecommerce_app/features/user/presentation/views/login_page.dart';
import 'package:ecommerce_app/features/user/presentation/views/signup_page.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.routeName: (_) => LoginPage(),
    SignupPage.routeName: (_) => SignupPage(),
    MyHomePage.routeName: (_) => const MyHomePage(),
  };
}
