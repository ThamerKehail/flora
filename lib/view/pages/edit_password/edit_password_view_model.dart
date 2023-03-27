import 'package:flutter/cupertino.dart';
import 'package:ward/data/repositories/edit_password_repository.dart';

class EditPasswordViewModel extends ChangeNotifier {
  final EditPasswordRepository editPasswordRepository;

  EditPasswordViewModel(
      this.editPasswordRepository,
      );

  Future editPassword({
    required String password,

  }) async {
    editPasswordRepository.editPassword(
      password: password,
    );
    notifyListeners();
  }
}
