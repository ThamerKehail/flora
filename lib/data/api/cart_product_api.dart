import 'package:ward/utils/global.dart';

import '../../dio/dio_client.dart';
import '../../models/cart_product_model.dart';

class CartProductApi {
  late final DioClient dioClient;
  CartProductApi(this.dioClient);
  Future<List<CartProductModel>> getAllCartProduct() async {
    try {
      final response = await dioClient.dio.get('api/cart/$userId');
      var data = CartProductModel.asListFromJson(response.data);

      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
