import 'package:ward/models/all_user_model.dart';

import '../../dio/dio_client.dart';

class AllUserApi {
  late final DioClient dioClient;
  AllUserApi(this.dioClient);
  Future<List<AllUserModel>> getAllPlaces() async {
    try {
      final response = await dioClient.dio.get('api/all_User');
      var data = AllUserModel.asListFromJson(response.data);

      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
