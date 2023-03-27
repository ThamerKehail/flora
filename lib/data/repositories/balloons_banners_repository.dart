import 'package:ward/data/api/balloons_banner_api.dart';
import 'package:ward/data/api/bannar_api.dart';
import 'package:ward/data/api/flower_banner_api.dart';
import 'package:ward/data/api/flowers_places_api.dart';
import 'package:ward/models/balloons_banners.dart';
import 'package:ward/models/banner.dart';
import 'package:ward/models/flowers_banners.dart';
import 'package:ward/models/places_model.dart';

class BalloonsBannerRepository {
  final BalloonsBannerApi _bannerApi;
  BalloonsBannerRepository(this._bannerApi);
  Future<List<BalloonsBannerModel>> getAllBanner() {
    return _bannerApi.getAllBanner();
  }
}
