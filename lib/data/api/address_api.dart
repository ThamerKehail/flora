import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/utils/const.dart';

import '../../dio/dio_client.dart';

class AddressApi {
  late final DioClient dioClient;
  AddressApi(this.dioClient);
  Future address({
    required String city,
    required String address,
    required String streetName,
    required int building,
    required int floor,
    required String mobile,
    required String note,
    required int status,
    required int business_id,
    required int userId,
  }) async {
    final data = {
      'city': city,
      'status': status,
      'business_id': business_id,
      'address': address,
      'strret_name': streetName,
      'building': building,
      'floor': floor,
      'mobile': mobile,
      'user_id': userId,
      'note': note,
    };
    final dio = Dio();

    Response response;
    response = await dioClient.dio.post('api/orders_address', data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
      print(body['status']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('order_id', body['order_id']);
      statusOrder = body['status'];
    } else {
      return null!;
    }
  }
}
