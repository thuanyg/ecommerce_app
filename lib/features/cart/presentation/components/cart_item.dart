import 'package:ecommerce_app/core/utils/image_helper.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatefulWidget {
  final CartProductEntity cartItem;
  final VoidCallback onDecrease, onIncrease, onRemove;

  const CartItem({
    super.key,
    required this.cartItem,
    required this.onDecrease,
    required this.onIncrease,
    required this.onRemove,
  });

  @override
  State<CartItem> createState() => CartItemState();
}

class CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.18,
            height: size.height * 0.13,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: ImageHelper.loadNetworkImage(
                widget.cartItem.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cartItem.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.043,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  "\$${widget.cartItem.price}",
                  style: GoogleFonts.poppins(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: size.width * 0.030,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onDecrease,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Text(
                      widget.cartItem.quantity.toString(),
                      style: GoogleFonts.poppins(),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    GestureDetector(
                      onTap: widget.onIncrease,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: widget.onRemove,
            child: CircleAvatar(
              backgroundColor: Colors.redAccent.withOpacity(0.07),
              radius: 18,
              child: const Icon(
                Icons.restore_from_trash_rounded,
                color: Colors.redAccent,
                size: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}