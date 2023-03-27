import 'package:ward/models/home_model.dart';

import '../../dio/dio_client.dart';

class HomeApi {
  late final DioClient dioClient;
  HomeApi(this.dioClient);
  Future<List<HomeModel>> getHomeData() async {
    try {
      final response = await dioClient.dio.get('api/All_api');
      var data = HomeModel.asListFromJson(response.data);
      print(data);
      return data;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
