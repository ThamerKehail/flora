import 'package:ward/models/balloons_banners.dart';
import 'package:ward/models/banner.dart';
import 'package:ward/models/flowers_banners.dart';

import '../../dio/dio_client.dart';

class BalloonsBannerApi {
  late final DioClient dioClient;
  BalloonsBannerApi(this.dioClient);
  Future<List<BalloonsBannerModel>> getAllBanner() async {
    try {
      final response = await dioClient.dio.get('api/banner_all');
      var data = BalloonsBannerModel.asListFromJson(response.data);

      return data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
