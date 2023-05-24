import 'package:flutter/material.dart';
import 'package:ward/data/repositories/login_repository.dart';
import 'package:ward/utils/cach_helper.dart';
import 'package:ward/utils/global.dart';

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
    oldPass = password;
    notifyListeners();
    await CacheHelper.saveData(key: 'password', value: password);
  }

  bool visibility = false;
  void visibilityChange() {
    visibility = !visibility;
    notifyListeners();
  }
}
