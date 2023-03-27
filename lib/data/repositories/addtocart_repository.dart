import 'package:ward/data/api/addtocart_api.dart';

class AddToCartRepository {
  final AddToCartApi _addToCartApi;

  AddToCartRepository(
    this._addToCartApi,
  );
  Future addToCart({
    required int productId,
    required int businessId,
    required int qty,
  }) {
    return _addToCartApi.addToCart(
      productId: productId,
      businessId: businessId,
      qty: qty,
    );
  }
}
