import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/domain/repository/order_repository.dart';

class BuyNowUseCase {
  final OrderRepository orderRepository;

  BuyNowUseCase(this.orderRepository);

  Future<Order> call(Order order) async {
    return await orderRepository.createOrder(order);
  }
}
