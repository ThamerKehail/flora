import 'package:ward/models/banner.dart';

import '../../dio/dio_client.dart';

class BannerApi {
  late final DioClient dioClient;
  BannerApi(this.dioClient);
  Future<List<BannerModel>> getAllBanner() async {
    try {
      final response = await dioClient.dio.get('api/banner_all');
      var data = BannerModel.asListFromJson(response.data);

      return data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
