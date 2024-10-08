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


List<PaymentMethod> paymentMethods = [
  PaymentMethod(
    name: 'Credit Card',
    icon: Icons.credit_card,
    description: 'Visa, MasterCard, Amex',
  ),
  PaymentMethod(
    name: 'E-Wallet',
    icon: Icons.account_balance_wallet,
    description: 'Google Pay, Apple Pay',
  ),
  PaymentMethod(
    name: 'Bank Transfer',
    icon: Icons.account_balance,
    description: 'Transfer directly from your bank',
  ),
  PaymentMethod(
    name: 'Cash',
    icon: Icons.account_balance,
    description: 'Cash on delivery',
  ),
];

class PaymentMethod {
  final String name;
  final IconData icon;
  final String description;

  PaymentMethod({required this.name, required this.icon, required this.description});
}

final List<FAQItem> faqs = [
  FAQItem(
    question: 'How can I place an order?',
    answer: 'To place an order, browse through our product catalog, select the items you want, and add them to your cart. Then, proceed to checkout to complete the purchase.',
  ),
  FAQItem(
    question: 'What payment methods do you accept?',
    answer: 'We accept various payment methods including credit cards, debit cards, PayPal, and online banking.',
  ),
  FAQItem(
    question: 'How do I track my order?',
    answer: 'After placing an order, you will receive an order confirmation email with a tracking link. You can use this link to track your order status.',
  ),
  FAQItem(
    question: 'Can I return or exchange a product?',
    answer: 'Yes, we offer returns and exchanges within 14 days of delivery, provided the items are unused and in their original packaging.',
  ),
  FAQItem(
    question: 'How do I contact customer support?',
    answer: 'You can reach our customer support team via email at support@ecommerceapp.com or by calling our hotline at +1-800-123-4567.',
  ),
];

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

List<Color> colorsProduct = <Color>[
  const Color(0xffF5E3DF),
  const Color(0xffECECEC),
  const Color(0xffE4F2DF),
  const Color(0xffD5E0ED),
  const Color(0xff3E3D40),
];

int fetchLimit = 20;
