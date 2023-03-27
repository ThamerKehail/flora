import 'package:dio/dio.dart';

import '../../dio/dio_client.dart';

class ForgetPasswordApi {
  late final DioClient dioClient;
  ForgetPasswordApi(this.dioClient);
  Future forgetPassword({
    required String password,
    required int userID,
  }) async {
    final data = {
      'password': password,
    };
    final dio = Dio();

    Response response;
    response =
        await dioClient.dio.post('api/account2/updata/$userID', data: data);
    if (response.statusCode == 200) {
      print(response.data);
      final body = response.data;
    } else {
      return null!;
    }
  }
}
