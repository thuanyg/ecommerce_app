import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
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
  List<Order> mockOrders = [
    Order(
      id: "67",
      userID: 1,
      date: DateTime.parse("2024-09-26 22:23:25.644065").toString(),
      status: true,
      name: "donromer",
      address: "No.6454, Hunters Creek Dr, San Antonio",
      phone: "1-765-789-6734",
      paymentMethod: "Cash on Delivery",
      carts: [
        CartProductEntity(
          id: "1",
          name: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
          price: 109.95,
          imageUrl: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
          quantity: 1,
        ),
      ],
    ),
    Order(
      id: "68",
      userID: 1,
      date: DateTime.parse("2024-09-26 22:24:18.996852").toString(),
      status: true,
      name: "donromer",
      address: "No.6454, Hunters Creek Dr, San Antonio",
      phone: "1-765-789-6734",
      paymentMethod: "Cash on Delivery",
      carts: [
        CartProductEntity(
          id: "1",
          name: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
          price: 109.95,
          imageUrl: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
          quantity: 2,
        ),
      ],
    ),
    Order(
      id: "69",
      userID: 1,
      date: DateTime.parse("2024-09-26 22:25:08.719869").toString(),
      status: true,
      name: "donromer",
      address: "No.6454, Hunters Creek Dr, San Antonio",
      phone: "1-765-789-6734",
      paymentMethod: "Cash on Delivery",
      carts: [
        CartProductEntity(
          id: "17",
          name: "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
          price: 39.99,
          imageUrl: "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg",
          quantity: 3,
        ),
        CartProductEntity(
          id: "18",
          name: "MBJ Women's Solid Short Sleeve Boat Neck V ",
          price: 9.85,
          imageUrl: "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg",
          quantity: 1,
        ),
        CartProductEntity(
          id: "19",
          name: "Opna Women's Short Sleeve Moisture",
          price: 7.95,
          imageUrl: "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg",
          quantity: 1,
        ),
      ],
    ),
  ];
  @override
  void initState() {
    super.initState();
    // Trigger event to load order history
    // BlocProvider.of<OrderBloc>(context).add(LoadOrderHistory());
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
          // if (state is OrderHistoryLoading) {
          //   return Center(child: CircularProgressIndicator());
          // } else if (state is OrderHistoryLoaded) {
          //   return _buildOrderList(state.orders);
          // } else if (state is OrderHistoryError) {
          //   return Center(child: Text('Error loading order history'));
          // }

          return _buildOrderList(mockOrders); // Default empty container
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
            SizedBox(height: 8),
            Text('Date: ${order.date}'),
            Text('Total: \$${_calculateTotal(order.carts)}'),
            SizedBox(height: 10),
            Text(
              'Status: ${order.status == true ? 'Completed' : 'Pending'}',
              style: TextStyle(
                color: order.status == true ? Colors.green : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to order details
                Navigator.pushNamed(context, OrderDetailPage.routeName, arguments: order);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal
              ),
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotal(List<CartProductEntity>? carts) {
    return carts?.fold(0, (total, item) => total! + (item.price * item.quantity)) ?? 0;
  }
}
