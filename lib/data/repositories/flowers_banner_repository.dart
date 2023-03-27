import 'package:ward/data/api/bannar_api.dart';
import 'package:ward/data/api/flower_banner_api.dart';
import 'package:ward/data/api/flowers_places_api.dart';
import 'package:ward/models/banner.dart';
import 'package:ward/models/flowers_banners.dart';
import 'package:ward/models/places_model.dart';

class FlowerBannerRepository {
  final FlowerBannerApi _bannerApi;
  FlowerBannerRepository(this._bannerApi);
  Future<List<FlowersBannerModel>> getAllBanner() {
    return _bannerApi.getAllBanner();
  }
}
