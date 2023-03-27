import 'package:dio/dio.dart';
import 'package:ward/utils/const.dart';

import '../../dio/dio_client.dart';

class EditPasswordApi {
  late final DioClient dioClient;
  EditPasswordApi(this.dioClient);
  Future editPassword({

    required String password,
  }) async {
    final data = {

      'password': password,
    };
    final dio = Dio();

    Response response;
    response = await dioClient.dio.post('api/account2/updata/$userId', data: data);
    if (response.statusCode == 200) {
      print(response.data);
      final body = response.data;



    } else {
      return null!;
    }
  }
}
