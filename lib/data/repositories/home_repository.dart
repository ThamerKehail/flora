import 'package:ward/data/api/home_api.dart';
import 'package:ward/models/home_model.dart';

class HomeRepository {
  final HomeApi _homeApi;
  HomeRepository(this._homeApi);
  Future<List<HomeModel>> getAllBusiness() {
    return _homeApi.getHomeData();
  }
}
