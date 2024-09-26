class CartProductEntity {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final int quantity;

  double get totalPrice => price * quantity;

  CartProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  CartProductEntity copyWith({int? quantity}) {
    return CartProductEntity(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }


  factory CartProductEntity.fromJson(Map<String, dynamic> json) {
    return CartProductEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble() // Chuyển đổi int sang double nếu cần
          : json['price'] as double,
      imageUrl: json['imageUrl'] as String,
      quantity: json['quantity'] as int,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}
