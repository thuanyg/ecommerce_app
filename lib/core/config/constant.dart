import 'package:flutter/material.dart';

// BASEURL for Call Data APIs
String baseUrl = "https://ecommerce-api-tulp.onrender.com";


List<Category> categories = [
  Category("Electronics", "assets/images/ic_category_electronics.png"),
  Category("Fashion", "assets/images/ic_category_fashion.png"),
  Category("Furniture", "assets/images/ic_category_furniture.png"),
  Category("Industrial", "assets/images/ic_category_industrial.png"),
  Category("Clothes", "assets/images/ic_clothes.png"),
  Category("Sneakers", "assets/images/ic_sneakers.png"),
  Category("Cosmetic", "assets/images/ic_cosmetics.png"),
  Category("Hoodies", "assets/images/ic_hoodies.png"),
  Category("Electronics", "assets/images/ic_gadget.png"),
  Category("Jewelery", "assets/images/ic_jewelry.png"),
  Category("Shoes", "assets/images/ic_shoes.png"),
  Category("Shorts", "assets/images/ic_shorts.png"),
];

class Category {
  String name;
  String image;

  Category(this.name, this.image);
}

List<NavigationBarItem> navigationBarItems = [
  NavigationBarItem("Home", "assets/images/ic_nav_home.png"),
  NavigationBarItem("Categories", "assets/images/ic_nav_category.png"),
  NavigationBarItem("My Cart", "assets/images/ic_nav_cart.png"),
  NavigationBarItem("Wishlist", "assets/images/ic_nav_wishlist.png"),
  NavigationBarItem("Profile", "assets/images/ic_nav_profile.png"),
];

class NavigationBarItem {
  String label;
  String image;

  NavigationBarItem(this.label, this.image);
}

List<Color> colorsProduct = <Color>[
  const Color(0xffF5E3DF),
  const Color(0xffECECEC),
  const Color(0xffE4F2DF),
  const Color(0xffD5E0ED),
  const Color(0xff3E3D40),
];

int fetchLimit = 20;
