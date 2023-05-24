import 'package:dio/dio.dart';
import 'package:ward/utils/global.dart';

import '../../dio/dio_client.dart';

class RateApi {
  late final DioClient dioClient;
  RateApi(this.dioClient);
  Future rate({
    required int businessId,
    required int rating,
  }) async {
    final data = {
      'business_id': businessId,
      'userID': userId,
      'rating': rating,
    };
    final dio = Dio();

    Response response;
    response = await dioClient.dio.post('api/generation', data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
    } else {
      return null!;
    }
  }
}
