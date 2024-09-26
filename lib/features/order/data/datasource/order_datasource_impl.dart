import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/order/data/datasource/order_datasource.dart';
import 'package:ecommerce_app/features/order/data/model/order.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_datasource.dart';
import 'package:ecommerce_app/features/product/data/models/product.dart';

class OrderDatasourceImpl extends OrderDatasource {
  final Dio dio;

  OrderDatasourceImpl({required this.dio});


  @override
  Future<ProductModel> fetchOrder(int id) async {
    return ProductModel.fromJson({});
  }

  @override
  Future<List<Order>> fetchOrders() async {
    // TODO: implement fetchOrders
    throw UnimplementedError();
  }

  @override
  Future<Order> createOrder(Order order) async {
    try {
      Response response = await dio.post(
        "https://66f51dc09aa4891f2a23e7f0.mockapi.io/Orders",
        data: order.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        // Map response data to User model
        return Order.fromJson(data);
      } else {
        throw Exception(
            "Failed to create. Status code: ${response.statusCode}");
      }
    } on DioError catch (dioError) {
      // Handle Dio-specific errors here
      throw Exception("Dio error: ${dioError.message}");
    } catch (e) {
      // General exception handling
      throw Exception("An error occurred: $e");
    }
  }

  @override
  Future<List<Order>> fetchProductsByCategory(String category, int limit) {
    // TODO: implement fetchProductsByCategory
    throw UnimplementedError();
  }
}
