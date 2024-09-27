import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ProductCardWidget extends StatelessWidget {
  String name;
  String price;
  String imageUrl;
  VoidCallback onPressed;
  VoidCallback onAddToCart;

  ProductCardWidget({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.onPressed,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffF4F4F4),
      elevation: 1,
      child: InkWell(
        onTap: onPressed,
        child: Stack(
          children: [
            SizedBox(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: 120,
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          height: 140,
                          width: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      price,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 14,
                        ),
                        Text("(4.5)"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              right: 8,
              child: InkWell(
                onTap: onAddToCart,
                borderRadius: BorderRadius.circular(100),
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
