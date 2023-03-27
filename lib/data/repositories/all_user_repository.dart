import 'package:ward/data/api/all_user_api.dart';
import 'package:ward/models/all_user_model.dart';

class AllUserRepository {
  final AllUserApi _allUserApi;
  AllUserRepository(this._allUserApi);
  Future<List<AllUserModel>> getAllUsers() {
    return _allUserApi.getAllPlaces();
  }
}
