import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/repository/favorite_repository.dart';

class CreateFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  CreateFavoriteUseCase(this.favoriteRepository);

  Future<Favorite> call(Favorite favorite) async {
    return await favoriteRepository.createFavorite(favorite);
  }
}