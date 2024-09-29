import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/repository/favorite_repository.dart';

class GetFavoritesUseCase {
  final FavoriteRepository favoriteRepository;

  GetFavoritesUseCase(this.favoriteRepository);

  Future<List<Favorite>> call(String userID) async {
    return await favoriteRepository.fetchFavorites(userID);
  }
}