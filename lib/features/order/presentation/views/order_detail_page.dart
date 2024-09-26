import 'package:ecommerce_app/features/cart/domain/entities/product.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailPage extends StatefulWidget {
  static const routeName = '/order-detail';

  OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late Order order;

  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context)?.settings.arguments as Order;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (BuildContext context, state) {
          if (state is OrderCreated) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderInfoSection(),
                    SizedBox(height: 20),
                    _buildAddressSection(),
                    SizedBox(height: 20),
                    _buildCartProductsSection(),
                    SizedBox(height: 20),
                    _buildPaymentSection(),
                    SizedBox(height: 20),
                    _buildOrderStatusSection(),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: Text("Error"),
          );
        },
      ),
    );
  }

  // Thông tin đơn hàng
  Widget _buildOrderInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildInfoRow('Order ID', "#${order.id}" ?? ''),
        _buildInfoRow('Order Date', order.date ?? ''),
      ],
    );
  }

  // Địa chỉ nhận hàng
  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Address',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildInfoRow('Name', order.name ?? ''),
        _buildInfoRow('Address', order.address ?? ''),
        _buildInfoRow('Phone', order.phone ?? ''),
      ],
    );
  }

  // Danh sách sản phẩm trong giỏ hàng
  Widget _buildCartProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Products',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          itemCount: order.carts?.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final product = order.carts![index];
            return _buildCartProductItem(product);
          },
        ),
      ],
    );
  }

  // Phương thức thanh toán
  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildInfoRow('Method', order.paymentMethod ?? ''),
      ],
    );
  }

  // Trạng thái đơn hàng
  Widget _buildOrderStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Status',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildInfoRow(
          'Status',
          order.status == true ? 'Completed' : 'Pending',
        ),
      ],
    );
  }

  // Hiển thị từng thông tin theo hàng
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // Hiển thị sản phẩm trong giỏ hàng
  Widget _buildCartProductItem(CartProductEntity product) {
    return Card(
      color: Colors.grey.shade500,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 50, height: 50),
        title: Text(
          product.name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('SL: ${product.quantity}',
            style: const TextStyle(color: Colors.white)),
        trailing: Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
