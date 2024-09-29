import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/config/routes.dart';
import 'package:ecommerce_app/features/cart/data/datasource/cart_local_datasource.dart';
import 'package:ecommerce_app/features/cart/data/models/product.dart';
import 'package:ecommerce_app/features/cart/data/repository/cart_repository_impl.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_product_to_cart.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/get_cart.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/quantity_control.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/remove_control.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/favorite/data/datasource/favorite_datasource_impl.dart';
import 'package:ecommerce_app/features/favorite/data/repository/favorite_repository_impl.dart';
import 'package:ecommerce_app/features/favorite/domain/usecase/check_favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/usecase/create_favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/usecase/get_favorites.dart';
import 'package:ecommerce_app/features/favorite/domain/usecase/remove_favorite.dart';
import 'package:ecommerce_app/features/favorite/presentation/blocs/favorite_bloc.dart';
import 'package:ecommerce_app/features/home/page_bloc.dart';
import 'package:ecommerce_app/features/order/data/datasource/order_datasource_impl.dart';
import 'package:ecommerce_app/features/order/data/repository/order_repository_impl.dart';
import 'package:ecommerce_app/features/order/domain/repository/order_repository.dart';
import 'package:ecommerce_app/features/order/domain/usecase/create_order.dart';
import 'package:ecommerce_app/features/order/domain/usecase/history_order.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_datasource_impl.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_by_category_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_products_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail/detail_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_category/product_category_bloc.dart';
import 'package:ecommerce_app/features/splash/splash_page.dart';
import 'package:ecommerce_app/features/user/data/datasource/user_datasource_impl.dart';
import 'package:ecommerce_app/features/user/data/repository/user_repository_impl.dart';
import 'package:ecommerce_app/features/user/domain/usecase/get_user.dart';
import 'package:ecommerce_app/features/user/domain/usecase/login_usecase.dart';
import 'package:ecommerce_app/features/user/domain/usecase/logout.dart';
import 'package:ecommerce_app/features/user/domain/usecase/signup_usecase.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/logout/logout_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/signup/signup_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path); // Use init() if not in Flutter context
  Hive.registerAdapter(
      CartProductModelAdapter()); // Ensure your model is registered
  final cartBox = await Hive.openBox<CartProductModel>('cartBox');
  final dio = Dio();
  // Product
  final productDatasource = ProductDatasourceImpl(dio: dio);
  final productRepository =
      ProductRepositoryImpl(dataSource: productDatasource);

  final fetchProducts = FetchProducts(productRepository);
  final fetchProductsByCategory = FetchProductsByCategory(productRepository);
  final fetchProductByID = FetchProductByID(productRepository);
  // Cart
  final cartDataSource = CartLocalDataSourceImpl(cartBox);
  final cartRepository = CartRepositoryImpl(cartDataSource);
  final addProductToCart = AddProductToCartUseCase(cartRepository);

  final getCart = GetCartUseCase(cartRepository);
  final quantityControl = QuantityControlUseCase(cartRepository);
  final removeControl = RemoveControlUseCase(cartRepository);
  // User
  final userDataSource = UserDatasourceImpl(dio: dio);
  final userRepository = UserRepositoryImpl(userDataSource);
  final userLogin = LoginUseCase(userRepository);
  final userLogout = LogOutUseCase(userRepository);
  final userSignUp = SignUpUseCase(userRepository);
  final getUser = GetUserUseCase(userRepository);

  // order
  final orderDataSource = OrderDatasourceImpl(dio: dio);
  final orderRepository = OrderRepositoryImpl(orderDataSource);
  final createOrder = CreateOrderUseCase(orderRepository);
  final historyOrder = HistoryOrderUseCase(orderRepository);

  // Favorite
  final favoriteDataSource = FavoriteDatasourceImpl(dio);
  final favoriteRepository = FavoriteRepositoryImpl(favoriteDataSource);
  final createFavorite = CreateFavoriteUseCase(favoriteRepository);
  final removeFavorite = RemoveFavoriteUseCase(favoriteRepository);
  final checkFavorite = CheckFavoriteUseCase(favoriteRepository);
  final getFavorites = GetFavoritesUseCase(favoriteRepository);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ProductBloc>(
        create: (context) => ProductBloc(
          fetchProducts: fetchProducts,
          fetchProductByID: fetchProductByID,
        ),
      ),
      BlocProvider<ProductCategoryBloc>(
        create: (context) => ProductCategoryBloc(fetchProductsByCategory),
      ),
      BlocProvider(
        create: (context) => DetailBloc(
          fetchProductByID: fetchProductByID,
        ),
      ),
      BlocProvider(
        create: (context) => CartBloc(
          addProductToCart: addProductToCart,
          getCartUseCase: getCart,
          quantityControlUseCase: quantityControl,
          removeControlUseCase: removeControl,
        ),
      ),
      BlocProvider(
        create: (context) => LoginBloc(loginUseCase: userLogin),
      ),
      BlocProvider(
        create: (context) => LogoutBloc(logOutUseCase: userLogout),
      ),
      BlocProvider(
        create: (context) => SignupBloc(signUpUseCase: userSignUp),
      ),
      BlocProvider(
        create: (context) => PersonalBloc(getUser),
      ),
      BlocProvider(
        create: (context) => OrderBloc(createOrder, historyOrder),
      ),
      BlocProvider(
        create: (context) => PageBloc(),
      ),
      BlocProvider(
        create: (context) => FavoriteBloc(
          createFavorite,
          removeFavorite,
          checkFavorite,
          getFavorites,
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);

    // Tùy chỉnh kiểu dáng của thanh trạng thái
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      routes: Routes.routes,
    );
  }
}
