import 'dart:io';

import 'package:ward/data/api/edit_profile_api.dart';
import 'package:ward/data/api/login_api.dart';
import 'package:ward/data/api/register_api.dart';

class EditProfileRepository {
  final EditProfileApi _editProfileApi;

  EditProfileRepository(
    this._editProfileApi,
  );
  Future editProfile({
    required String fName,
    required String lName,
    required String email,
    required File img,
  }) {
    return _editProfileApi.editProfile(
      fName: fName,
      lName: lName,
      email: email,
      img: img,
    );
  }
}
