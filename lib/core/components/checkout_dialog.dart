import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutDialog extends StatefulWidget {
  Function(
      {required TextEditingController nameController,
      required TextEditingController addressController,
      required TextEditingController phoneController,
      required String selectedPaymentMethod}) onCheckOut;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String selectedPaymentMethod = "Cash on Delivery";

  CheckoutDialog({required this.onCheckOut, super.key});

  @override
  CheckoutDialogState createState() => CheckoutDialogState();
}

class CheckoutDialogState extends State<CheckoutDialog> {
  final _formKey = GlobalKey<FormState>();

  List<String> paymentMethods = ['Credit Card', 'PayPal', 'Cash on Delivery'];

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
                  String userid =
                      await StorageUtils.getToken(key: "userid") ?? "";
                  BlocProvider.of<PersonalBloc>(context)
                      .add(PersonalLoadInformation(userid));
                });
              }
              if (state is PersonalLoaded) {
                widget.nameController.text =
                    state.user.name!.firstname.toString() +
                        state.user.name!.lastname.toString();
                widget.phoneController.text = state.user.phone.toString();
                widget.addressController.text =
                    "No.${state.user.address?.number!}, ${state.user.address!.street.toString()}, ${state.user.address!.city.toString()}";
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Name Field
                    TextFormField(
                      controller: widget.nameController,
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
                      controller: widget.addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Phone Field
                    TextFormField(
                      controller: widget.phoneController,
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
                      value: widget.selectedPaymentMethod,
                      hint: const Text('Select Payment Method'),
                      onChanged: (String? newValue) {
                        setState(() {
                          widget.selectedPaymentMethod = newValue!;
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
                    controller: widget.nameController,
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
                    controller: widget.addressController,
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
                    controller: widget.phoneController,
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
                    value: widget.selectedPaymentMethod,
                    hint: const Text('Select Payment Method'),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.selectedPaymentMethod = newValue!;
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
              widget.onCheckOut(
                addressController: widget.addressController,
                nameController: widget.nameController,
                phoneController: widget.phoneController,
                selectedPaymentMethod: widget.selectedPaymentMethod,
              );
            }
          },
          child: const Text('Checkout'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.nameController.dispose();
    widget.addressController.dispose();
    widget.phoneController.dispose();
    super.dispose();
  }
}
