import 'dart:async';

import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/usecase/check_favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/usecase/create_favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/usecase/get_favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/usecase/get_favorites.dart';
import 'package:ecommerce_app/features/favorite/domain/usecase/remove_favorite.dart';
import 'package:ecommerce_app/features/favorite/presentation/blocs/favorite_event.dart';
import 'package:ecommerce_app/features/favorite/presentation/blocs/favorite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  List<Favorite> favorites = [];

  final CreateFavoriteUseCase createFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final CheckFavoriteUseCase checkFavoriteUseCase;
  final GetFavoritesUseCase fetchFavorites;

  // final GetFavoriteUseCase fetchFavorite;

  FavoriteBloc(
    this.createFavoriteUseCase,
    this.removeFavoriteUseCase,
    this.checkFavoriteUseCase,
    this.fetchFavorites,
    // this.fetchFavorite,
  ) : super(FavoriteInitial()) {
    on<CreateFavorite>(_createFavorite);
    on<RemoveFavorite>(_removeFavorite);
    on<CheckFavorite>(_checkFavorite);
    on<LoadFavorites>(_loadFavorites);
    // on<LoadFavorite>(_loadFavorite);
  }

  FutureOr<void> _createFavorite(
      CreateFavorite event, Emitter<FavoriteState> emit) async {
    emit(FavoriteCreateLoading());

    try {
      Favorite favorite = await createFavoriteUseCase.call(event.favorite);
      if (favorite.id != null) {
        emit(FavoriteCreated(favorite.id.toString()));
      } else {
        emit(FavoriteCreateError("Error"));
      }
    } on Exception catch (e) {
      emit(FavoriteCreateError(e.toString()));
    }
  }

  FutureOr<void> _removeFavorite(
      RemoveFavorite event, Emitter<FavoriteState> emit) async {
    emit(FavoriteRemoveLoading());
    try {
      await removeFavoriteUseCase.call(event.id);
      emit(FavoriteRemoved(event.id));
      favorites.removeWhere((e) => e.id == event.id);
      emit(FavoritesFetchLoaded(favorites));
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  FutureOr<void> _checkFavorite(
      CheckFavorite event, Emitter<FavoriteState> emit) async {
    Favorite favorite =
        await checkFavoriteUseCase.call(event.userID, event.productID);

    if (favorite.id != null) {
      emit(FavoriteCreated(favorite.id.toString()));
    } else {
      emit(FavoriteRemoved(favorite.id.toString()));
    }
  }

  FutureOr<void> _loadFavorites(
      LoadFavorites event, Emitter<FavoriteState> emit) async {
    emit(FavoritesFetchLoading());
    try {
      String userID = await StorageUtils.getToken(key: "userid") ?? "0";
      final favorites = await fetchFavorites(userID);
      if (favorites.isNotEmpty) {
        emit(FavoritesFetchLoaded(favorites));
      } else {
        emit(FavoritesFetchFailed("Favorites empty"));
      }
    } on Exception catch (e) {
      emit(FavoritesFetchFailed(e.toString()));
    }
  }
}
