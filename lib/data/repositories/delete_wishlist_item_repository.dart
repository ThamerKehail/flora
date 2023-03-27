import '../api/delete_wishlist_item_api.dart';

class DeleteWishlistItemRepository {
  final DeleteWishlistItemApi _deleteWishlistItemApi;

  DeleteWishlistItemRepository(
    this._deleteWishlistItemApi,
  );
  Future delete({
    required int id,
  }) {
    return _deleteWishlistItemApi.delete(id: id);
  }
}
