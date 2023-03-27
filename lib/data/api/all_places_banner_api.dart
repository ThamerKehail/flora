import 'package:ward/models/all_places_banner.dart';

import '../../dio/dio_client.dart';

class AllPlacesBannerApi {
  late final DioClient dioClient;
  AllPlacesBannerApi(this.dioClient);
  Future<List<AllPlacesBannerModel>> getAllBanner() async {
    try {
      final response = await dioClient.dio.get('api/banner_all');
      var data = AllPlacesBannerModel.asListFromJson(response.data);

      return data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
