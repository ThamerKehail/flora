import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/data/repositories/login_repository.dart';
import 'package:ward/data/repositories/register_repository.dart';

import '../../../utils/const.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository loginRepository;

  LoginViewModel(this.loginRepository);
  Future login(
      {required String mobile,
      required String password,
      required BuildContext context}) async {
    loginRepository.login(
      password: password,
      mobile: mobile,
      context: context,
    );
    notifyListeners();
  }

  bool visibility = true;
  void visibilityChange() {
    visibility = !visibility;
    notifyListeners();
  }
}
