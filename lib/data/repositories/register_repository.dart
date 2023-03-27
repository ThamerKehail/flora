import 'package:flutter/cupertino.dart';
import 'package:ward/data/api/register_api.dart';

class RegisterRepository {
  final RegisterApi _registerApi;

  RegisterRepository(
    this._registerApi,
  );
  Future register({
    required String email,
    required String fname,
    required String lname,
    required String mobile,
    required String password,
    required String profileImg,
    required BuildContext context,
  }) {
    return _registerApi.register(
      email: email,
      password: password,
      fname: fname,
      lname: lname,
      mobile: mobile,
      context: context,
    );
  }
}
