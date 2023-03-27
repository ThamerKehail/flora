import 'package:flutter/foundation.dart';
import 'package:ward/data/repositories/user_repository.dart';
import 'package:ward/models/user_model.dart';

class ProfileViewModel extends ChangeNotifier {
  UserRepository userRepository;
  ProfileViewModel(this.userRepository);
  bool isLoading = true;
  Future<List<Client>>? user;

  Future<void> getUserInfo() async {
    isLoading = true;

    user = userRepository.getUserInfo();

    notifyListeners();
  }
}
