import 'package:ward/data/api/all_places_banner_api.dart';
import 'package:ward/models/all_places_banner.dart';

class AllPlacesBannerRepository {
  final AllPlacesBannerApi _allPlacesBannerApi;
  AllPlacesBannerRepository(this._allPlacesBannerApi);
  Future<List<AllPlacesBannerModel>> getAllBanner() {
    return _allPlacesBannerApi.getAllBanner();
  }
}
