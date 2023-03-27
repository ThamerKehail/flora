import 'package:ward/models/order_history.dart';

import '../../dio/dio_client.dart';
import '../../utils/const.dart';

class OrdersApi {
  late final DioClient dioClient;
  OrdersApi(this.dioClient);
  Future<List<Orders>> getAllOrders() async {
    try {
      final response = await dioClient.dio.get('api/orders/$userId');
      var data = Orders.asListFromJson(response.data);

      return data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
