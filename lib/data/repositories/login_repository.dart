import 'package:flutter/material.dart';
import 'package:ward/data/api/login_api.dart';

class LoginRepository {
  final LoginApi _loginApi;

  LoginRepository(
    this._loginApi,
  );
  Future login(
      {required String mobile,
      required String password,
      required BuildContext context}) {
    return _loginApi.login(
      password: password,
      mobile: mobile,
      context: context,
    );
  }
}
