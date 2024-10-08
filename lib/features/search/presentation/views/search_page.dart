import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/components/bottom_sheet_add_to_cart.dart';
import 'package:ecommerce_app/core/components/product_item.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/core/utils/functions.dart';
import 'package:ecommerce_app/features/search/data/datasource/search_datasource_impl.dart';
import 'package:ecommerce_app/features/search/data/repository/search_repository_impl.dart';
import 'package:ecommerce_app/features/search/domain/repository/search_repository.dart';
import 'package:ecommerce_app/features/search/domain/usecase/search_product.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/history/history_bloc.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/history/history_event.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/history/history_state.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/search_event.dart';
import 'package:ecommerce_app/features/search/presentation/bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  static String routeName = "/SearchPage";

  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryBloc>(context).add(GetHistorySearch());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBodySearch(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.only(right: 18),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                BlocProvider.of<SearchBloc>(context).add(ResetSearchProduct());
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xffF0F2F1),
                    width: 1.3,
                  ),
                ),
                child: TextField(
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) {
                      _debounce!.cancel();
                    }

                    if (value == "") {
                      context.read<SearchBloc>().add(ResetSearchProduct());
                    } else {
                      _debounce = Timer(const Duration(milliseconds: 1500), () {
                        context.read<SearchBloc>().add(ResetSearchProduct());
                        context
                            .read<SearchBloc>()
                            .add(SearchProduct(value.trim(), fetchLimit));
                      });
                    }
                  },
                  onSubmitted: (value) {
                    if (value.trim() != "") {
                      context
                          .read<HistoryBloc>()
                          .add(SaveHistorySearch(value.trim()));
                      context.read<SearchBloc>().add(ResetSearchProduct());
                      context
                          .read<SearchBloc>()
                          .add(SearchProduct(value.trim(), fetchLimit));
                    }
                  },
                  style: const TextStyle(height: 1),
                  controller: _searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBodySearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(
              child: Lottie.asset(
                "assets/animations/loading.json",
                width: 90,
              ),
            );
          }
          if (state is SearchLoaded) {
            return ProductGrid(state: state);
          }
          if (state is SearchEmpty) {
            return const Center(
              child: Text("No results"),
            );
          }
          if (state is SearchInitial) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Last search"),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<HistoryBloc>(context)
                              .add(RemoveAllHistorySearch());
                        },
                        child: const Text(
                          "Clear all",
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<HistoryBloc, HistoryState>(
                      builder: (context, state) {
                        if (state is HistoryLoaded) {
                          return ListView.builder(
                            itemCount: state.list.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.history),
                                title: Text(state.list[index].query),
                                onTap: () {
                                  context
                                      .read<SearchBloc>()
                                      .add(ResetSearchProduct());

                                  context.read<SearchBloc>().add(
                                        SearchProduct(state.list[index].query,
                                            fetchLimit),
                                      );

                                  _searchController.text =
                                      state.list[index].query;
                                },
                                trailing: InkWell(
                                  borderRadius: BorderRadius.circular(200),
                                  onTap: () {
                                    context.read<HistoryBloc>().add(
                                          RemoveHistorySearch(
                                              state.list[index].query),
                                        );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Text("X"),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        if (state is HistoryEmpty) {
                          return const Center(
                            child: Text("Search anything..."),
                          );
                        }
                        return const Text("....");
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final SearchLoaded state;

  const ProductGrid({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: state.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
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
