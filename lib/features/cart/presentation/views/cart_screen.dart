import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:ecommerce_app/features/cart/presentation/components/cart_item.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_completed_page.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/CartScreen";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(LoadMyCart());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderCreated) {
            BlocProvider.of<CartBloc>(context).add(RemoveAllProduct());
            DialogUtils.hide(context);
            Navigator.pushReplacementNamed(
                context, OrderCompletePage.routeName);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.060,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "My Cart",
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.050,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return Center(
                      child: Lottie.asset(
                        "assets/animations/loading.json",
                        width: 100,
                      ),
                    );
                  }
                  if (state is CartError) {
                    return const Center(
                      child: Text("Something went wrong!!!. Please try again"),
                    );
                  }
                  if (state is CartEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.25,
                          ),
                          Icon(
                            Icons.shopping_bag,
                            size: size.width * 0.20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          Text(
                            "Your cart is empty!",
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  if (state is CartLoaded) {
                    final priceCaculator = BlocProvider.of<CartBloc>(context)
                        .getCartPriceState(state.products);
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: state.products.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Products",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: state.products.length,
                                            itemBuilder: (context, index) {
                                              return CartItem(
                                                onRemove: () {
                                                  String productId =
                                                      state.products[index].id;
                                                  BlocProvider.of<CartBloc>(
                                                          context)
                                                      .add(
                                                    RemoveProductFromCart(
                                                        productId),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              247, 247, 247),
                                                      content: Text(
                                                        "Item removed!",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                cartItem: state.products[index],
                                                onIncrease: () {
                                                  String productID =
                                                      state.products[index].id;
                                                  BlocProvider.of<CartBloc>(
                                                          context)
                                                      .add(
                                                    IncreaseCartProduct(
                                                        productID),
                                                  );
                                                },
                                                onDecrease: () {
                                                  String productID =
                                                      state.products[index].id;
                                                  BlocProvider.of<CartBloc>(
                                                          context)
                                                      .add(
                                                    DecreaseCartProduct(
                                                        productID),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.25,
                                          ),
                                          Icon(
                                            Icons.shopping_bag,
                                            size: size.width * 0.20,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.020,
                                          ),
                                          Text(
                                            "Your cart is empty!",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          SizedBox(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order Info",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.040,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.010,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sub Total",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  Text(
                                    "\$${priceCaculator.subtotal}",
                                    style: GoogleFonts.poppins(),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.008,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Shipping",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  Text(
                                    "+\$${priceCaculator.shippingCost}",
                                    style: GoogleFonts.poppins(),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.008,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tax",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  Text(
                                    "+\$${priceCaculator.tax}",
                                    style: GoogleFonts.poppins(),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "\$${priceCaculator.totalPrice}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.030,
                              ),
                              SizedBox(
                                width: size.width,
                                height: size.height * 0.055,
                                child: ElevatedButton(
                                  onPressed: checkout,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orangeAccent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Checkout (\$${priceCaculator.totalPrice})",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: Text("Something went wrong!!!. Please try again"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkout() {
    showDialog(
      context: context,
      builder: (context) {
        return CheckoutDialog();
      },
    );
  }
}

class CheckoutDialog extends StatefulWidget {
  @override
  CheckoutDialogState createState() => CheckoutDialogState();
}

class CheckoutDialogState extends State<CheckoutDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  List<String> paymentMethods = ['Credit Card', 'PayPal', 'Cash on Delivery'];
  String selectedPaymentMethod =
      "Cash on Delivery"; // Store selected payment method

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Orders'),
      backgroundColor: Colors.white,
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: BlocBuilder<PersonalBloc, PersonalState>(
            builder: (context, state) {
              if (state is PersonalInitial) {
                Future.microtask(() async {
                  String userid = await StorageUtils.getToken(key: "userid") ?? "";
                  BlocProvider.of<PersonalBloc>(context)
                      .add(PersonalLoadInformation(userid));
                });
              }
              if (state is PersonalLoaded) {
                nameController.text = state.user.name!.firstname.toString() +
                    state.user.name!.lastname.toString();
                phoneController.text = state.user.phone.toString();
                addressController.text =
                    "No.${state.user.address?.number!}, ${state.user.address!.street.toString()}, ${state.user.address!.city.toString()}";
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Name Field
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Address Field
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Phone Field
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Payment Field
                    // Payment Method Selection
                    DropdownButtonFormField<String>(
                      value: selectedPaymentMethod,
                      hint: const Text('Select Payment Method'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPaymentMethod = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a payment method';
                        }
                        return null;
                      },
                      items: paymentMethods
                          .map<DropdownMenuItem<String>>((String method) {
                        return DropdownMenuItem<String>(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                    ),
                  ],
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name Field
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // Address Field
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // Phone Field
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // Payment Field
                  // Payment Method Selection
                  DropdownButtonFormField<String>(
                    value: selectedPaymentMethod,
                    hint: const Text('Select Payment Method'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPaymentMethod = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a payment method';
                      }
                      return null;
                    },
                    items: paymentMethods
                        .map<DropdownMenuItem<String>>((String method) {
                      return DropdownMenuItem<String>(
                        value: method,
                        child: Text(method),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        // Submit Button
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              paymentCheckoutAction();
            }
          },
          child: const Text('Checkout'),
        ),
      ],
    );
  }

  void paymentCheckoutAction() async {
    DialogUtils.showLoadingDialog(context);

    String? id = await StorageUtils.getToken(key: "userid");

    String name = nameController.text.trim();
    String address = addressController.text.trim();
    String phone = phoneController.text.trim();

    final carts =
        await BlocProvider.of<CartBloc>(context).getCartUseCase.call();

    Order order = Order(
      phone: phone,
      address: address,
      name: name,
      date: DateTime.now().toString(),
      paymentMethod: selectedPaymentMethod,
      status: true,
      userID: id,
      carts: carts,
    );

    BlocProvider.of<OrderBloc>(context).add(CreateOrder(order));
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
