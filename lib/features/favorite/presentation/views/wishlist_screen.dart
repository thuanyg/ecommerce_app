import 'package:ecommerce_app/core/config/colors.dart';
import 'package:ecommerce_app/core/utils/functions.dart';
import 'package:ecommerce_app/core/utils/image_helper.dart';
import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';
import 'package:ecommerce_app/features/favorite/presentation/blocs/favorite_bloc.dart';
import 'package:ecommerce_app/features/favorite/presentation/blocs/favorite_event.dart';
import 'package:ecommerce_app/features/favorite/presentation/blocs/favorite_state.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail/detail_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static String routeName = "/WishlistScreen";

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    String userID = await StorageUtils.getValue(key: "userid") ?? "0";
    BlocProvider.of<FavoriteBloc>(context).add(LoadFavorites(userID));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: .2,
        shadowColor: AppColors.enableColor,
        centerTitle: true,
        title: const Text(
          "My Wishlist",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          print(state);
          if (state is FavoritesFetchLoading) {
            return Center(
              child: Lottie.asset(
                "assets/animations/loading.json",
                width: 90,
              ),
            );
          }

          if (state is FavoritesFetchFailed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.playlist_remove,
                    size: size.width * 0.20,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Text(
                    "Your wishlist is empty!",
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            );
          }

          if (state is FavoritesFetchLoaded) {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                return WishlistCard(
                  favorite: state.favorites[index],
                  addedAt:
                      DateTime.parse(state.favorites[index].date.toString()),
                  onRemove: () {
                    BlocProvider.of<FavoriteBloc>(context).add(
                        RemoveFavorite(state.favorites[index].id.toString()));
                    BlocProvider.of<FavoriteBloc>(context).add(
                      LoadFavorites(
                        state.favorites[index].userID.toString(),
                      ),
                    );
                  },
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(
                      ProductDetail.routeName,
                      arguments: state.favorites[index].product?.id.toString(),
                    )
                        .then((_) {
                      _loadFavorites();
                    });
                    ;
                  },
                  onAddToCart: () {
                    showBottomSheetAddToCart(
                        context, state.favorites[index].product!);
                  },
                );
              },
            );
          }

          return Center(
            child: Lottie.asset(
              "assets/animations/loading.json",
              width: 90,
            ),
          );
        },
      ),
    );
  }
}

class WishlistCard extends StatelessWidget {
  final Favorite favorite;
  final VoidCallback onRemove, onAddToCart, onTap;
  final DateTime addedAt;

  const WishlistCard({
    super.key,
    required this.favorite,
    required this.onRemove,
    required this.addedAt,
    required this.onTap,
    required this.onAddToCart,
  });

  // Helper function to calculate time difference
  String timeAgo(DateTime dateTime) {
    final Duration diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays > 1 ? "s" : ""} ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hour${diff.inHours > 1 ? "s" : ""} ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? "s" : ""} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image
              SizedBox(
                width: 48,
                height: 48,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageHelper.loadNetworkImage(
                    favorite.product!.image.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title
                    Text(
                      favorite.product!.title.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    // Product Price
                    Row(
                      children: [
                        Text(
                          '\$${favorite.product!.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Time since added
                        Text(
                          timeAgo(addedAt),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Action Buttons (Move to cart, share, etc.)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: onAddToCart,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: const LinearGradient(
                                colors: [AppColors.enableColor, Colors.teal],
                              ),
                            ),
                            child: const Text(
                              'Move to Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // TODO: Implement Share functionality
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.blueAccent,
                            ),
                            child: const Text(
                              'Share',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: onRemove,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.redAccent,
                            ),
                            child: const Text(
                              'Remove',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
