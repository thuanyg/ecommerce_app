import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/features/favorite/data/datasource/favorite_datasource.dart';
import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';

class FavoriteDatasourceImpl extends FavoriteDataSource {
  final Dio dio;

  FavoriteDatasourceImpl(this.dio);

  @override
  Future<Favorite> createFavorite(Favorite favorite) async {
    try {
      final f = await checkFavorite(favorite.userID.toString(), favorite.product!.id.toString());

      if (f.id != null) {
        throw Exception("This product is already in the favorites list.");
      }

      Response response = await dio.post(
        "$baseUrl/favorites",
        data: favorite.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        return Favorite.fromJson(data);
      } else {
        throw Exception(
            "Failed to create fav. Status code: ${response.statusCode}");
      }
    } on DioError catch (dioError) {
      throw Exception("Dio error: ${dioError.message}");
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  @override
  Future<Favorite> fetchFavorite(String favoriteID) async {
    try {
      Response response = await dio.get(
        "$baseUrl/favorites/$favoriteID",
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return Favorite.fromJson(data);
      } else {
        throw Exception(
            "Failed to get favorite. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // General exception handling
      throw Exception("An error occurred: $e");
    }
  }

  @override
  Future<List<Favorite>> fetchFavorites(String userid) async {
    try {
      // Gửi request tới server để lấy danh sách yêu thích của người dùng
      Response response = await dio.get(
        "$baseUrl/favorites?userID=$userid&_sort=date&_order=desc",
      );
      // Kiểm tra status code
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data; // Chuyển đổi thành danh sách

        // Ánh xạ từng phần tử trong data thành đối tượng Favorite
        final listFavorites = data.map((item) => Favorite.fromJson(item)).toList();
        return listFavorites;
      } else {
        // Ném lỗi nếu status code không phải 200
        throw Exception("Failed to get favorites. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Xử lý lỗi chung
      throw Exception("An error occurred: $e");
    }
  }


  @override
  Future<void> removeFavorite(String favoriteID) async {
    try {
      Response response = await dio.delete("$baseUrl/favorites/$favoriteID");

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Favorite removed successfully.");
      } else {
        throw Exception(
            "Failed to remove favorite. Status code: ${response.statusCode}");
      }

      throw Exception();
    } catch (e) {
      // General exception handling
      throw Exception("An error occurred: $e");
    }
  }

  @override
  Future<Favorite> checkFavorite(String userID, String productID) async {
    try {
      Response res = await dio.get(
        "$baseUrl/favorites",
        queryParameters: {
          "userID": userID,
          "product.id": productID,
        },
      );
      List<dynamic> existingFavorites = res.data;

      if (existingFavorites.isNotEmpty) {
        return Favorite.fromJson(existingFavorites[0]);
      }
      return Favorite();
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
