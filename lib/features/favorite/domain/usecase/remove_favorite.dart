import 'package:ecommerce_app/features/favorite/data/model/favorite.dart';
import 'package:ecommerce_app/features/favorite/domain/repository/favorite_repository.dart';

class RemoveFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  RemoveFavoriteUseCase(this.favoriteRepository);

  Future<void> call(String id) async {
    return await favoriteRepository.removeFavorite(id);
  }
}