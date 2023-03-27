import 'package:ward/data/api/bannar_api.dart';
import 'package:ward/data/api/flowers_places_api.dart';
import 'package:ward/models/banner.dart';
import 'package:ward/models/places_model.dart';

class BannerRepository {
  final BannerApi _bannerApi;
  BannerRepository(this._bannerApi);
  Future<List<BannerModel>> getAllBanner() {
    return _bannerApi.getAllBanner();
  }
}
