import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/domain/repository/order_repository.dart';

class HistoryOrderUseCase  {
  final OrderRepository orderRepository;

  HistoryOrderUseCase(this.orderRepository);

  Future<List<Order>> call(String userid){
    return orderRepository.fetchOrders(userid);
  }
}