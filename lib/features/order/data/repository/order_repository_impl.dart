import 'package:ecommerce_app/features/order/data/datasource/order_datasource.dart';
import 'package:ecommerce_app/features/order/data/datasource/order_datasource_impl.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/domain/repository/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository{

  final OrderDatasource dataSource;


  OrderRepositoryImpl(this.dataSource);

  @override
  Future<Order> createOrder(Order order) async {
    return await dataSource.createOrder(order);
  }

  @override
  Future<Order> fetchOrder(int id) {
    // TODO: implement fetchOrder
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> fetchOrders() {
    // TODO: implement fetchOrders
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> fetchProductsByCategory(String category, int limit) {
    // TODO: implement fetchProductsByCategory
    throw UnimplementedError();
  }
}