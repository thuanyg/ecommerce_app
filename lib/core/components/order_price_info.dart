import 'package:ecommerce_app/features/cart/presentation/blocs/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPriceInfo extends StatelessWidget {
  const OrderPriceInfo({
    super.key,
    required this.size,
    required this.priceCalculate,
  });

  final Size size;
  final CartPriceState priceCalculate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Info",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: size.width * 0.040,
            color: Colors.teal
          ),
        ),
        SizedBox(
          height: size.height * 0.010,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sub Total",
              style: GoogleFonts.poppins(),
            ),
            Text(
              "\$${priceCalculate.subtotal.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.008,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Shipping",
              style: GoogleFonts.poppins(),
            ),
            Text(
              "+\$${priceCalculate.shippingCost}",
              style: GoogleFonts.poppins(),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.008,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tax",
              style: GoogleFonts.poppins(),
            ),
            Text(
              "+\$${priceCalculate.tax}",
              style: GoogleFonts.poppins(),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.015,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.teal
              ),
            ),
            Text(
              "\$${priceCalculate.totalPrice.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ],
    );
  }
}
