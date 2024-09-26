import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/domain/repository/order_repository.dart';

class CreateOrderUseCase  {
  final OrderRepository orderRepository;

  CreateOrderUseCase(this.orderRepository);

  Future<Order> call(Order order){
    return orderRepository.createOrder(order);
  }
}