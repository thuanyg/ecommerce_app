import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/repository/favorite_repository.dart';

class CheckFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  CheckFavoriteUseCase(this.favoriteRepository);

  Future<Favorite> call(String userID, String productID) async {
    return await favoriteRepository.checkFavorite(userID, productID);
  }
}