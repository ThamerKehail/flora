import '../../dio/dio_client.dart';
import '../../models/product_model.dart';

class ProductApi {
  late final DioClient dioClient;
  ProductApi(this.dioClient);
  Future<List<Product>> getAllProduct(int businessId) async {
    try {
      final response = await dioClient.dio.get('api/all_product/$businessId');

      return Product.asListFromJson(response.data);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
