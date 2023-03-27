import 'package:ward/models/banner.dart';
import 'package:ward/models/flowers_banners.dart';

import '../../dio/dio_client.dart';

class FlowerBannerApi {
  late final DioClient dioClient;
  FlowerBannerApi(this.dioClient);
  Future<List<FlowersBannerModel>> getAllBanner() async {
    try {
      final response = await dioClient.dio.get('api/banner_all');
      var data = FlowersBannerModel.asListFromJson(response.data);

      return data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
