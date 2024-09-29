import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class Favorite {
  String? id;
  String? userID;
  ProductEntity? product;
  String? date;

  Favorite({this.id, this.userID, this.product, this.date});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    product =
    json['product'] != null ? new ProductEntity.fromJson(json['product']) : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['date'] = this.date;
    return data;
  }
}