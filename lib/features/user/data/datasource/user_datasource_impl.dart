import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/config/constant.dart';
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
  Future<String> login(String email, String password) async {
    try {
      Response response = await dio.post(
        "$baseUrl/login",
        data: UserLogin(email: email, password: password).toJson(),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return data["accessToken"] ?? "";
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
          "$baseUrl/signup",
        data: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        // Map response data to User model
        return User.fromJson(data);
      } else {
        throw Exception(
            response.data.toString());
      }
    } on DioError catch (dioError) {
      throw Exception("Dio error: ${dioError.message}");
    } catch (e) {
      // General exception handling
      throw Exception("An error occurred: $e");
    }
  }

  @override
  Future<User> getUser(String id) async {
    try {
      Response response = await dio.get(
        "$baseUrl/users/$id",
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
