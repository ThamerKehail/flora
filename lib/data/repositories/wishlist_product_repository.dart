import 'package:ward/data/api/wishlist_product_api.dart';

import '../../models/wishlist_model.dart';

class WishlistProductRepository {
  final WishlistProductApi _wishlistProductApi;
  WishlistProductRepository(this._wishlistProductApi);
  Future<List<WishlistModel>> getAllWishlistProduct() {
    return _wishlistProductApi.getAllWishlistProduct();
  }
}
