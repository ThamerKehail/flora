import 'package:ward/models/home_image.dart';

import '../../dio/dio_client.dart';

class HomeImageApi {
  late final DioClient dioClient;
  HomeImageApi(this.dioClient);
  Future<List<HomeImage>> getHomeImage() async {
    try {
      final response = await dioClient.dio.get('api/image');
      var data = HomeImage.asListFromJson(response.data);
      print("Home Banner Image =$data");

      return data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
