import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/repository/favorite_repository.dart';

class GetFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  GetFavoriteUseCase(this.favoriteRepository);

  Future<Favorite> call(String favoriteID) async {
    return await favoriteRepository.fetchFavorite(favoriteID);
  }
}