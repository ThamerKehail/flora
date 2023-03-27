import 'package:ward/models/flowers_balloons_banner_model.dart';

import '../../dio/dio_client.dart';

class FlowerBalloonsBannerApi {
  late final DioClient dioClient;
  FlowerBalloonsBannerApi(this.dioClient);
  Future<List<FlowersBalloonsBannerModel>> getAllBanner() async {
    try {
      final response = await dioClient.dio.get('api/banner_all');
      var data = FlowersBalloonsBannerModel.asListFromJson(response.data);

      return data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
