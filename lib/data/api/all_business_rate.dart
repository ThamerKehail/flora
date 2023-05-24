import 'package:ward/utils/global.dart';

import '../../dio/dio_client.dart';
import '../../models/all_business_rate.dart';

class AllBusinessRateApi {
  late final DioClient dioClient;
  AllBusinessRateApi(this.dioClient);
  Future<List<AllBusinessRate>> getAllBusinessRate() async {
    try {
      final response = await dioClient.dio.get('api/orders_rate/$userId');
      var data = AllBusinessRate.asListFromJson(response.data);
      print(data);
      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
