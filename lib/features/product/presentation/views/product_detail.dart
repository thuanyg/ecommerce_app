import 'package:ecommerce_app/core/components/bottom_sheet_buynow.dart';
import 'package:ecommerce_app/core/components/checkout_dialog.dart';
import 'package:ecommerce_app/core/config/colors.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/core/utils/functions.dart';
import 'package:ecommerce_app/core/utils/image_helper.dart';
import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:ecommerce_app/features/cart/presentation/views/cart_screen.dart';
import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';
import 'package:ecommerce_app/features/favorite/presentation/blocs/favorite_bloc.dart';
import 'package:ecommerce_app/features/favorite/presentation/blocs/favorite_event.dart';
import 'package:ecommerce_app/features/favorite/presentation/blocs/favorite_state.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_completed_page.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail/detail_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail/detail_event.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ProductDetail extends StatefulWidget {
  static String routeName = "/ProductDetail";

  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late String productID;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      productID = ModalRoute.of(context)!.settings.arguments as String;
      BlocProvider.of<DetailBloc>(context).add(LoadProductByID(productID));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderCreated) {
            DialogUtils.hide(context);
            Navigator.pushReplacementNamed(
                context, OrderCompletePage.routeName);
          }
        },
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              // Check Favorite
              checkFavorite(productID);
              return Center(
                child: Lottie.asset(
                  "assets/animations/loading.json",
                  width: 90,
                ),
              );
            }

            if (state is ProductDetailLoadFailed) {
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
                      "Product is empty!",
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              );
            }

            if (state is ProductDetailLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 260,
                            width: MediaQuery.of(context).size.width,
                            child: ImageHelper.loadNetworkImage(
                              state.product.image.toString(),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 16),
                                          Text(
                                            state.product.title.toString(),
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 2,
                                          ),
                                          Text(
                                            "\$${state.product.price?.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BlocBuilder<FavoriteBloc, FavoriteState>(
                                      builder: (context, favoriteState) {
                                        if (favoriteState is FavoriteCreated) {
                                          return InkWell(
                                            onTap: () {
                                              removeFavoriteProduct(
                                                  favoriteState.favoriteID
                                                      .toString());
                                            },
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.redAccent,
                                                //(0x74ABABAB)
                                              ),
                                              child: const Icon(
                                                Icons.favorite,
                                                // color: Colors.black12,
                                                color: Colors.white70,
                                                size: 28,
                                              ),
                                            ),
                                          );
                                        }

                                        if (favoriteState is FavoriteRemoved) {
                                          return InkWell(
                                            onTap: () {
                                              favoriteProduct(state.product);
                                            },
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0x74ABABAB),
                                              ),
                                              child: const Icon(
                                                Icons.favorite,
                                                color: Colors.black12,
                                                size: 28,
                                              ),
                                            ),
                                          );
                                        }

                                        return InkWell(
                                          onTap: () {
                                            favoriteProduct(state.product);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0x74ABABAB),
                                            ),
                                            child: const Icon(
                                              Icons.favorite,
                                              color: Colors.black12,
                                              size: 28,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  "Choose the color",
                                  style: TextStyle(
                                    color: Color(0xff939393),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                buildChooseColor(context),
                                const SizedBox(height: 10),
                                buildSeller(),
                                const SizedBox(height: 10),
                                const Text(
                                  "Description of product",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.product.description.toString(),
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          child: ElevatedButton(
                            onPressed: () {
                              showBottomSheetAddToCart(context, state.product);
                            },
                            style: ButtonStyle(
                              backgroundColor: const WidgetStatePropertyAll(
                                  AppColors.enableColor),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Add to cart",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        // BUY NOW
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          child: OutlinedButton(
                            onPressed: () {
                              showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return BottomSheetBuyNow(
                                      onCheckOutBuyNow: (quantity) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CheckoutDialog(
                                              onCheckOut: ({
                                                required addressController,
                                                required nameController,
                                                required phoneController,
                                                required selectedPaymentMethod,
                                              }) {
                                                CartProductEntity cartProduct =
                                                    CartProductEntity(
                                                  id: state.product.id!,
                                                  name: state.product.title!,
                                                  price: state.product.price!,
                                                  imageUrl:
                                                      state.product.image!,
                                                  quantity: quantity,
                                                );

                                                paymentCheckoutBuyNowAction(
                                                  nameController:
                                                      nameController,
                                                  addressController:
                                                      addressController,
                                                  phoneController:
                                                      phoneController,
                                                  paymentMethod:
                                                      selectedPaymentMethod,
                                                  cartProductEntity:
                                                      cartProduct,
                                                  context: context,
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  });
                            },
                            style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(
                                  Color(0xffF0F2F1),
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                side: const WidgetStatePropertyAll(
                                  BorderSide(
                                    color: Color(0xffD9D9D9),
                                  ),
                                )),
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }

            return Center(
              child: Lottie.asset(
                "assets/animations/loading.png",
                width: 90,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildSeller() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xffF0F2F1),
          ),
          bottom: BorderSide(
            color: Color(0xffF0F2F1),
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            child: Image.asset("assets/images/ic_apple.png"),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Mart",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "online 12 mins ago",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff939393),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
            child: OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                side: const WidgetStatePropertyAll(
                  BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                ),
              ),
              child: const Text("Follow"),
            ),
          )
        ],
      ),
    );
  }

  Row buildChooseColor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        5,
        (index) {
          return InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 5 - 18,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  color: colorsProduct[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: true,
      title: const Text("Details product"),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  int quantity = 0;
                  state.products.forEach((e) => quantity += e.quantity);
                  return Positioned(
                    top: 8,
                    right: 8,
                    child: Badge(
                      label: Text(quantity.toString()),
                      isLabelVisible: true,
                    ),
                  );
                }
                BlocProvider.of<CartBloc>(context).add(LoadMyCart());
                return const SizedBox.shrink();
              },
            ),
          ],
        )
      ],
    );
  }

  void favoriteProduct(ProductEntity product) async {
    String userid = await StorageUtils.getToken(key: "userid") ?? "0";

    Favorite favorite = Favorite(
      userID: userid,
      date: DateTime.now().toString(),
      product: product,
    );

    BlocProvider.of<FavoriteBloc>(context).add(CreateFavorite(favorite));
  }

  void removeFavoriteProduct(String favoriteID) async {
    BlocProvider.of<FavoriteBloc>(context).add(RemoveFavorite(favoriteID));
  }

  void checkFavorite(String productID) async {
    String id = await StorageUtils.getToken(key: "userid") ?? "0";
    BlocProvider.of<FavoriteBloc>(context).add(CheckFavorite(id, productID));
  }
}

void paymentCheckoutBuyNowAction({
  required TextEditingController nameController,
  required TextEditingController addressController,
  required TextEditingController phoneController,
  required String paymentMethod,
  required BuildContext context,
  required CartProductEntity cartProductEntity,
}) async {
  DialogUtils.showLoadingDialog(context);

  String? id = await StorageUtils.getToken(key: "userid");

  String name = nameController.text.trim();
  String address = addressController.text.trim();
  String phone = phoneController.text.trim();

  Order order = Order(
    phone: phone,
    address: address,
    name: name,
    date: DateTime.now().toString(),
    paymentMethod: paymentMethod,
    status: true,
    userID: id,
    carts: [cartProductEntity],
  );

  BlocProvider.of<OrderBloc>(context).add(CreateOrder(order));
}
