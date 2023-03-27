import 'package:ward/data/api/delete_cart_item_api.dart';

class DeleteCartItemRepository {
  final DeleteCartItemApi _deleteCartItemApi;

  DeleteCartItemRepository(
    this._deleteCartItemApi,
  );
  Future delete({
    required int id,
  }) {
    return _deleteCartItemApi.delete(id: id);
  }
}
