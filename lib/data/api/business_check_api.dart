import 'package:dio/dio.dart';

import '../../dio/dio_client.dart';
import '../../utils/const.dart';

class CheckBusinessApi {
  late final DioClient dioClient;
  CheckBusinessApi(this.dioClient);
  Future checkBusiness({
    required int orderId,
  }) async {
    final data = {
      'order_id': '$orderId',
      'user_id': '$userId',
    };

    Response response;
    response = await dioClient.dio.post('api/orders_cheak', data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
    } else {
      return null!;
    }
  }
}
