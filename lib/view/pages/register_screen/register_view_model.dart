import 'package:flutter/material.dart';
import 'package:ward/data/repositories/register_repository.dart';
import 'package:ward/models/all_user_model.dart';

import '../../../data/repositories/all_user_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterRepository registerRepository;
  final AllUserRepository allUserRepository;

  RegisterViewModel(this.registerRepository, this.allUserRepository);
  Future<List<AllUserModel>>? users;
  bool isLoading = true;
  List<AllUserModel> allUsers = [];

  Future<void> getAllUsers() async {
    isLoading = true;

    users = allUserRepository.getAllUsers();
    allUsers = (await users)!;

    notifyListeners();
  }

  Future register({
    required String email,
    required String fname,
    required String lname,
    required String mobile,
    required String password,
    required String profileImg,
    required BuildContext context,
  }) async {
    registerRepository.register(
      email: email,
      password: password,
      fname: fname,
      lname: lname,
      mobile: mobile,
      profileImg: profileImg,
      context: context,
    );
    notifyListeners();
  }

  snackBar(String? message, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  bool visibilityPassword = true;
  void visibilityChange() {
    visibilityPassword = !visibilityPassword;
    notifyListeners();
  }

  bool visibilityConfirmPassword = true;
  void visibilityChangeConfirmPassword() {
    visibilityConfirmPassword = !visibilityConfirmPassword;
    notifyListeners();
  }
}
