import 'package:ecommerce_app/core/config/constant.dart';
import 'package:flutter/material.dart';

InkWell buildCategoryItem(
    {required BuildContext context,
      required int index,
      required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      width: MediaQuery.of(context).size.width / 4 - 18,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFF4F5FD),
          width: 3,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            categories[index].image,
            height: 36,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 3),
          Expanded(
            child: Text(
              categories[index].name,
            ),
          ),
        ],
      ),
    ),
  );
}