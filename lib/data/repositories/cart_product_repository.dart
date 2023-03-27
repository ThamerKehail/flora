import 'package:ward/data/api/cart_product_api.dart';
import 'package:ward/models/cart_product_model.dart';

class CartProductRepository {
  final CartProductApi _cartProductApi;
  CartProductRepository(this._cartProductApi);
  Future<List<CartProductModel>> getAllCartProduct() {
    return _cartProductApi.getAllCartProduct();
  }
}
