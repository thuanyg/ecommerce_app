import 'package:ecommerce_app/features/cart/domain/entities/product.dart';

class Order {
  List<CartProductEntity>? carts;
  int? userID;
  String? date;
  bool? status;
  String? name;
  String? address;
  String? phone;
  String? paymentMethod;
  String? id;

  Order(
      {this.carts,
      this.userID,
      this.date,
      this.status,
      this.name,
      this.address,
      this.phone,
      this.paymentMethod,
      this.id});

  // fromJson method
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      carts: json['carts'] != null
          ? (json['carts'] as List)
              .map((item) => CartProductEntity.fromJson(item))
              .toList()
          : null,
      userID: json['userID'] as int?,
      date: json['date'] as String?,
      status: json['status'] as bool?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      id: json['id'] as String?,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'carts': carts?.map((cartItem) => cartItem.toJson()).toList(),
      'userID': userID,
      'date': date,
      'status': status,
      'name': name,
      'address': address,
      'phone': phone,
      'paymentMethod': paymentMethod,
      'id': id,
    };
  }
}
