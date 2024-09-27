import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/views/order_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Adjust your import based on your project structure
import 'package:ecommerce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';

class OrderHistoryPage extends StatefulWidget {
  static const routeName = '/order-history';

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {

  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  void fetchOrder() async {
    String userid = await StorageUtils.getToken(key: "userid") ?? "0";
    BlocProvider.of<OrderBloc>(context)
        .add(LoadHistoryOrder(userid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is HistoryOrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryOrderLoaded) {
            return _buildOrderList(state.orders);
          } else if (state is HistoryOrderFailed) {
            return const Center(child: Text('Error loading order history'));
          }
          return const Center(child: Text('Empty')); // Default empty container
        },
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(orders[index]);
      },
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Date: ${order.date}'),
            Text('Total: \$${_calculateTotal(order.carts)}'),
            const SizedBox(height: 8),
            Text(
              'Status: ${order.status == true ? 'Completed' : 'Pending'}',
              style: TextStyle(
                color: order.status == true ? Colors.green : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Navigate to order details
                Navigator.pushNamed(context, OrderDetailPage.routeName,
                    arguments: order);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('View Details', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotal(List<CartProductEntity>? carts) {
    return carts?.fold(
            0, (total, item) => total! + (item.price * item.quantity)) ??
        0;
  }
}
