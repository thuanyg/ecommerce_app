import 'package:ecommerce_app/features/order/data/model/order.dart';

abstract class OrderRepository {
  Future<List<Order>> fetchOrders(String userID);
  Future<Order> createOrder(Order order);
  Future<List<Order>> fetchProductsByCategory(String category, int limit);
  Future<Order> fetchOrder(String id);
}