import 'package:ward/models/avg_business_rate.dart';

import '../../dio/dio_client.dart';

class AvgBusinessApi {
  late final DioClient dioClient;
  AvgBusinessApi(this.dioClient);
  Future<AvgBusinessRate> getAvgRate(int businessId) async {
    try {
      final response = await dioClient.dio.get('api/review/$businessId');

      return AvgBusinessRate.fromJson(response.data);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
