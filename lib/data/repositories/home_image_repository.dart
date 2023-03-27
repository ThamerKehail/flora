import 'package:ward/data/api/home_image_api.dart';
import 'package:ward/models/home_image.dart';

class HomeImageRepository {
  final HomeImageApi _homeImageApi;
  HomeImageRepository(this._homeImageApi);
  Future<List<HomeImage>> getHomeImage() {
    return _homeImageApi.getHomeImage();
  }
}
