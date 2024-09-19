import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/features/product/presentation/components/back_prev.dart';
import 'package:ecommerce_app/features/product/presentation/views/product_by_category.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        margin: const EdgeInsets.only(top: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackPrevScreen(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "Shop by Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProductByCategory(),
                            settings: RouteSettings(
                              arguments: categories[index].name.toString(),
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Ink(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xfff4f4f4),
                        ),
                        child: ListTile(
                          minTileHeight: 70,
                          leading: Image.asset(
                            categories[index].image,
                            height: 50,
                          ),
                          title: Text(
                            categories[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
