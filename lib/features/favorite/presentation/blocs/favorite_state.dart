import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}


// Create
class FavoriteCreateLoading extends FavoriteState {}

class FavoriteCreated extends FavoriteState {
  String favoriteID;

  FavoriteCreated(this.favoriteID);
}

class FavoriteCreateError extends FavoriteState {
  String message;

  FavoriteCreateError(this.message);
}

// Remove
class FavoriteRemoveLoading extends FavoriteState {}

class FavoriteRemoved extends FavoriteState {
  String id;

  FavoriteRemoved(this.id);
}

//Get list
class FavoritesFetchLoading extends FavoriteState {}

class FavoritesFetchLoaded extends FavoriteState {
  List<Favorite> favorites;
  FavoritesFetchLoaded(this.favorites);
}

class FavoritesFetchFailed extends FavoriteState {
  String message;

  FavoritesFetchFailed(this.message);
}

//Get favorite entity


