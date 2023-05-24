import 'package:dio/dio.dart';

import '../../dio/dio_client.dart';
import '../../utils/global.dart';

class AddToWishlistApi {
  late final DioClient dioClient;
  AddToWishlistApi(this.dioClient);
  Future addToWishlist({
    required int productId,
  }) async {
    final data = {
      'userID': "$userId",
      'product_id': '$productId',
    };
    final dio = Dio();

    Response response;
    response = await dioClient.dio.post('api/wishlist', data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
    } else {
      return null!;
    }
  }
}
