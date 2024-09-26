// product_datasource.dart
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/product/data/models/product.dart';

abstract class OrderDatasource {
  Future<List<Order>> fetchOrders();
  Future<Order> createOrder(Order order);
  Future<List<Order>> fetchProductsByCategory(String category, int limit);
  Future<ProductModel> fetchOrder(int id);
}