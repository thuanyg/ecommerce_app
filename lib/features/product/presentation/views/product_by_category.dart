import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_datasource_impl.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/usecases/fetch_product_by_category_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product_state.dart';
import 'package:ecommerce_app/features/product/presentation/components/back_prev.dart';
import 'package:ecommerce_app/features/product/presentation/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductByCategory extends StatelessWidget {
  const ProductByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    String category =
        ModalRoute.of(context)?.settings.arguments as String? ?? "";

    if(category == "Men") category = "men's clothing";
    if(category == "Women") category = "women's clothing";

    final dio = Dio();
    final productDataSource = ProductDatasourceImpl(dio: dio);
    final productRepo = ProductRepositoryImpl(dataSource: productDataSource);
    final fetchProductsByCategory = FetchProductsByCategory(productRepo);

    return BlocProvider(
      create: (context) =>
          ProductBloc(fetchProductsByCategory: fetchProductsByCategory)
            ..add(LoadProductsByCategory(50, category.toLowerCase())),
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.only(top: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackPrevScreen(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "$category(243)",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductError) {
                      return Center(child: Text(state.message));
                    }
                    if (state is ProductLoaded) {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 2,
                          childAspectRatio: (150.0 / 220.0),
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return ProductCardWidget(
                            name: state.products[index].title.toString(),
                            price: '${state.products[index].price}\$',
                            imageUrl: state.products[index].image.toString(),
                            onPressed: () {},
                          );
                        },
                      );
                    }
                    return const Center(child: Text("No products"));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
