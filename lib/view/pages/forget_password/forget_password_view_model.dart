import 'package:flutter/cupertino.dart';
import 'package:ward/data/repositories/edit_password_repository.dart';
import 'package:ward/data/repositories/forget_password_repository.dart';

class ForgetPasswordViewModel extends ChangeNotifier {
  final ForgetPasswordRepository forgetPasswordRepository;

  ForgetPasswordViewModel(
    this.forgetPasswordRepository,
  );

  Future editPassword({
    required String password,
    required int userID,
  }) async {
    forgetPasswordRepository.forgetPassword(
      password: password,
      userID: userID,
    );
    notifyListeners();
  }
}
