import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:hive/hive.dart';
part 'product.g.dart';
@HiveType(typeId: 0)
class CartProductModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  late final int quantity;

  CartProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  factory CartProductModel.fromEntity(CartProductEntity product) {
    return CartProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      imageUrl: product.imageUrl,
      quantity: product.quantity,
    );
  }

  CartProductEntity toEntity() {
    return CartProductEntity(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity,
    );
  }
}
