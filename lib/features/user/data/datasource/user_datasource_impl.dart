import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/cart/data/models/product.dart';
import 'package:ecommerce_app/features/user/data/datasource/user_datasource.dart';
import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/data/models/user_login.dart';
import 'package:hive/hive.dart';

class UserDatasourceImpl extends UserDatasource {
  final Dio dio;

  UserDatasourceImpl({required this.dio});

  @override
  Future<String> login(String username, String password) async {
    try {
      Response response = await dio.post(
        "https://fakestoreapi.com/auth/login",
        data: UserLogin(username: username, password: password).toJson(),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return data["token"] ?? "";
      }
      throw Exception();
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<User> signUp(User user) async {
    try {
      Response response = await dio.post(
        "https://fakestoreapi.com/users",
        data: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        // Map response data to User model
        return User.fromJson(data);
      } else {
        throw Exception(
            "Failed to sign up. Status code: ${response.statusCode}");
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
  Future<User> getUser(int id) async {
    try {
      Response response = await dio.get(
        "https://fakestoreapi.com/users/$id",
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return User.fromJson(data);
      } else {
        throw Exception(
            "Failed to get user. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // General exception handling
      throw Exception("An error occurred: $e");
    }
  }

  @override
  Future<void> logout() async{
    StorageUtils.remove(key: "userid");
    Hive.box<CartProductModel>('cartBox').clear();
  }
}
