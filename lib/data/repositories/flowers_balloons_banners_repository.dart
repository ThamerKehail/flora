import 'package:ward/data/api/flowers_ballons_banner_api.dart';
import 'package:ward/models/flowers_balloons_banner_model.dart';

class FlowerBalloonsBannerRepository {
  final FlowerBalloonsBannerApi _flowerBalloonsBannerApi;
  FlowerBalloonsBannerRepository(this._flowerBalloonsBannerApi);
  Future<List<FlowersBalloonsBannerModel>> getAllBanner() {
    return _flowerBalloonsBannerApi.getAllBanner();
  }
}
