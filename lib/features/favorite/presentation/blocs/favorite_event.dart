import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';

abstract class FavoriteEvent {}

class CreateFavorite extends FavoriteEvent {
  Favorite favorite;

  CreateFavorite(this.favorite);
}

class RemoveFavorite extends FavoriteEvent {
  String id;

  RemoveFavorite(this.id);
}

class CheckFavorite extends FavoriteEvent {
  String userID, productID;

  CheckFavorite(this.userID, this.productID);
}


class LoadFavorite extends FavoriteEvent {
  String favoriteID;

  LoadFavorite(this.favoriteID);
}

class LoadFavorites extends FavoriteEvent {
  String userID;

  LoadFavorites(this.userID);
}
