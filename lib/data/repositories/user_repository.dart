import 'package:ward/data/api/user_api.dart';
import 'package:ward/models/user_model.dart';

class UserRepository {
  final UserApi _userApi;

  UserRepository(
    this._userApi,
  );
  Future<List<Client>> getUserInfo() {
    return _userApi.getUserInfo();
  }
}
