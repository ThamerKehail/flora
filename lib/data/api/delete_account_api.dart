import 'package:ward/utils/const.dart';

import '../../dio/dio_client.dart';

class DeleteAccountApi {
  late final DioClient dioClient;
  DeleteAccountApi(this.dioClient);
  Future<String> deleteAccount() async {
    try {
      final response = await dioClient.dio.get('api/userDelete/$userId');
      if (response.statusCode == 200)
        return "Success";
      else
        return "Failed";
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
