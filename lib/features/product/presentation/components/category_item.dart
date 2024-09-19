import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  String imageUrl;
  String categoryName;
  VoidCallback onPressed;

  CategoryItemWidget({
    super.key,
    required this.categoryName,
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(40), // Image radius
                child: Image.asset(imageUrl),
              ),
            ),
            const SizedBox(height: 8),
            Text(categoryName)
          ],
        ),
      ),
    );
  }
}
