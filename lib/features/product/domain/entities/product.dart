import 'dart:ffi';

import 'package:ecommerce_app/features/product/data/models/product.dart';

class ProductEntity {
  String? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;

  ProductEntity({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
  });

  ProductEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] as double);
    description = json['description'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    return data;
  }
}
