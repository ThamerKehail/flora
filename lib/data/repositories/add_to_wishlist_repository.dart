import 'package:ward/data/api/add_to_wishlist_api.dart';

class AddToWishlistRepository {
  final AddToWishlistApi _addToWishlistApi;

  AddToWishlistRepository(
    this._addToWishlistApi,
  );
  Future addToWishlist({
    required int productId,
  }) {
    return _addToWishlistApi.addToWishlist(
      productId: productId,
    );
  }
}
