import '../api/update_qty_api.dart';

class UpdateQtyRepository {
  final UpdateQtyApi _updateQtyApi;

  UpdateQtyRepository(
    this._updateQtyApi,
  );
  Future updateQty({
    required int id,
    required int qty,
  }) {
    return _updateQtyApi.updateQty(
      id: id,
      qty: qty,
    );
  }
}
