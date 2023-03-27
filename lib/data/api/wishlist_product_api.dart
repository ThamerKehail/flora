import '../../dio/dio_client.dart';
import '../../models/wishlist_model.dart';

class WishlistProductApi {
  late final DioClient dioClient;
  WishlistProductApi(this.dioClient);
  Future<List<WishlistModel>> getAllWishlistProduct() async {
    try {
      final response = await dioClient.dio.get('api/wishlist/34');
      var data = WishlistModel.asListFromJson(response.data);

      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
