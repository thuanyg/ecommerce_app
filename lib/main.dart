import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/config/routes.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_product_to_cart.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_datasource_impl.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_by_category_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_products_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/views/home_page.dart';
import 'package:ecommerce_app/features/user/data/datasource/user_datasource_impl.dart';
import 'package:ecommerce_app/features/user/data/repository/user_repository_impl.dart';
import 'package:ecommerce_app/features/user/domain/repository/user_repository.dart';
import 'package:ecommerce_app/features/user/domain/usecase/login_usecase.dart';
import 'package:ecommerce_app/features/user/domain/usecase/signup_usecase.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/signup/signup_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/views/login_page.dart';
import 'package:ecommerce_app/features/user/presentation/views/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final dio = Dio();
  // Product
  final productDatasource = ProductDatasourceImpl(dio: dio);
  final productRepository =
      ProductRepositoryImpl(dataSource: productDatasource);

  final fetchProducts = FetchProducts(productRepository);
  final fetchProductsByCategory = FetchProductsByCategory(productRepository);
  final fetchProductByID = FetchProductByID(productRepository);
  // Cart
  final addProductToCart = AddProductToCartUseCase();
  // User
  final userDataSource = UserDatasourceImpl(dio: dio);
  final userRepository = UserRepositoryImpl(userDataSource);
  final userLogin = LoginUseCase(userRepository);
  final userSignUp = SignUpUseCase(userRepository);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ProductBloc>(
        create: (context) => ProductBloc(
          fetchProducts: fetchProducts,
          fetchProductsByCategory: fetchProductsByCategory,
          fetchProductByID: fetchProductByID,
        ),
      ),
      BlocProvider(
        create: (context) => CartBloc(addProductToCart: addProductToCart),
      ),
      BlocProvider(
        create: (context) => LoginBloc(loginUseCase: userLogin),
      ),
      BlocProvider(
        create: (context) => SignupBloc(signUpUseCase: userSignUp),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: Routes.routes,
    );
  }
}
