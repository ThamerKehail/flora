import 'package:ward/models/business_rated_model.dart';
import 'package:ward/utils/const.dart';

import '../../dio/dio_client.dart';

class BusinessRatedApi {
  late final DioClient dioClient;
  BusinessRatedApi(this.dioClient);
  Future<List<BusinessRated>> getAllBusinessRate() async {
    try {
      final response =
          await dioClient.dio.get('api/orders_rate_cheack/$userId');
      var data = BusinessRated.asListFromJson(response.data);
      print(data);
      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
