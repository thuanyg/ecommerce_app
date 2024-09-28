import 'package:ecommerce_app/core/config/colors.dart';
import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetAddToCart extends StatefulWidget {
  const BottomSheetAddToCart({super.key, required this.onAddToCart});

  final Function(int) onAddToCart;

  @override
  State<BottomSheetAddToCart> createState() => _BottomSheetAddToCartState();
}

class _BottomSheetAddToCartState extends State<BottomSheetAddToCart> {
  final List<String> productSizes = ['S', 'M', 'L', 'XL'];
  String selectedSize = "S";
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Size',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: productSizes.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ListTile(
                    minTileHeight: 48,
                    tileColor: selectedSize == productSizes[index]
                        ? AppColors.enableColor.withOpacity(0.2)
                        : Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    leading: Icon(
                      Icons.check_circle,
                      color: selectedSize == productSizes[index]
                          ? AppColors.enableColor
                          : Colors.grey[300],
                    ),
                    title: Text(
                      productSizes[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedSize == productSizes[index]
                            ? AppColors.enableColor
                            : Colors.black87,
                        fontWeight: selectedSize == productSizes[index]
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedSize = productSizes[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'Select Quantity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              IconButton(
                onPressed: selectedQuantity > 1
                    ? () {
                        setState(() {
                          selectedQuantity--;
                        });
                      }
                    : null,
                icon: const Icon(Icons.remove),
                color: Colors.blue,
              ),
              Text(
                selectedQuantity.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedQuantity++;
                  });
                },
                icon: const Icon(Icons.add),
                color: AppColors.enableColor,
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                widget.onAddToCart(selectedQuantity);
                // Navigator.pop(context);
              },
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                backgroundColor:
                    const WidgetStatePropertyAll(AppColors.enableColor),
              ),
              child: const Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
