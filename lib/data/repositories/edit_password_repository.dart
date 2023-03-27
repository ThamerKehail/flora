import 'package:ward/data/api/edit_password_api.dart';

class EditPasswordRepository {
  final EditPasswordApi _editPasswordApi;

  EditPasswordRepository(
      this._editPasswordApi,
      );
  Future editPassword({

    required String password,
  }) {
    return _editPasswordApi.editPassword(
      password: password,

    );
  }
}