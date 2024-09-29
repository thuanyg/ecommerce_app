import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/config/constant.dart';
import 'package:ecommerce_app/features/favorite/data/datasource/favorite_datasource.dart';
import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/repository/favorite_repository.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {
  final FavoriteDataSource favoriteDataSource;

  FavoriteRepositoryImpl(this.favoriteDataSource);

  @override
  Future<Favorite> createFavorite(Favorite favorite) async {
    return await favoriteDataSource.createFavorite(favorite);
  }

  @override
  Future<Favorite> fetchFavorite(String favoriteID) async {
    return await favoriteDataSource.fetchFavorite(favoriteID);
  }

  @override
  Future<List<Favorite>> fetchFavorites(String userid) async {
    return await favoriteDataSource.fetchFavorites(userid);
  }

  @override
  Future<void> removeFavorite(String favoriteID) async {
    return await favoriteDataSource.removeFavorite(favoriteID);
  }

  @override
  Future<Favorite> checkFavorite(String userID, String productID) async {
    return await favoriteDataSource.checkFavorite(userID, productID);
  }
}
