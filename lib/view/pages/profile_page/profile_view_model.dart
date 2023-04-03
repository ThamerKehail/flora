import 'package:flutter/foundation.dart';
import 'package:ward/data/repositories/user_repository.dart';
import 'package:ward/models/user_model.dart';

import '../../../data/repositories/delete_account_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  UserRepository userRepository;
  DeleteAccountRepository deleteAccountRepository;
  ProfileViewModel(this.userRepository, this.deleteAccountRepository);
  bool isLoading = true;
  Future<List<Client>>? user;

  Future<void> getUserInfo() async {
    isLoading = true;

    user = userRepository.getUserInfo();

    notifyListeners();
  }

  Future<String> deleteAccount() {
    return deleteAccountRepository.deleteAccount();
  }
}
