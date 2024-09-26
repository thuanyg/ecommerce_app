import 'package:flutter/material.dart';

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
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 220,
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      price,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: InkWell(
                onTap: onAddToCart,
                borderRadius: BorderRadius.circular(100),
                child: const CircleAvatar(
                  radius: 18,
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
