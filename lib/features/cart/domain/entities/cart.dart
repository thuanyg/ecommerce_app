class CartEntity {
  int? id;
  int? userId;
  String? date;
  List<Products>? products;
  int? iV;

  CartEntity({this.id, this.userId, this.date, this.products, this.iV});
}

class Products {
  int? productId;
  int? quantity;

  Products({this.productId, this.quantity});
}