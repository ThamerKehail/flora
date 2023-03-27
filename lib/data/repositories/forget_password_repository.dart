import 'package:ward/data/api/edit_password_api.dart';

import '../api/forget_password_api.dart';

class ForgetPasswordRepository {
  final ForgetPasswordApi _forgetPasswordApi;

  ForgetPasswordRepository(
    this._forgetPasswordApi,
  );
  Future forgetPassword({
    required String password,
    required int userID,
  }) {
    return _forgetPasswordApi.forgetPassword(
      password: password,
      userID: userID,
    );
  }
}
