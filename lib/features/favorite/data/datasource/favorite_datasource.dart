import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';

abstract class FavoriteDataSource {
  Future<List<Favorite>> fetchFavorites(String userid);
  Future<Favorite> fetchFavorite(String favoriteID);
  Future<Favorite> createFavorite(Favorite favorite);
  Future<void> removeFavorite(String favoriteID);
  Future<Favorite> checkFavorite(String userID, String productID);
}