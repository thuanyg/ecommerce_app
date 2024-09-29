import 'package:ecommerce_app/core/utils/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SlideItem extends StatelessWidget {
  VoidCallback onTap;

  SlideItem({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Stack(
            children: [
              ImageHelper.loadAssetImage(
                "assets/images/img_slider01.png",
                width: MediaQuery.of(context).size.width,
                height: 300,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(25)
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        child: Text(
                          "30% OFF",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "On Headphones",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const Text(
                      "Exclusive Sales",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
