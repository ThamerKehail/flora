import 'package:ward/models/user_model.dart';

import '../../dio/dio_client.dart';
import '../../utils/global.dart';

class UserApi {
  late final DioClient dioClient;
  UserApi(this.dioClient);
  Future<List<Client>> getUserInfo() async {
    try {
      print('/////////////////$userId////////////////////////');
      print(userId);
      final response = await dioClient.dio.get('api/User/$userId');
      print(response.data);
      return Client.asListFromJson(response.data);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
