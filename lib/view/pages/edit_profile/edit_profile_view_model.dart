import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/data/repositories/edit_profile_repository.dart';
import 'package:ward/models/user_model.dart';

import '../../../data/repositories/user_repository.dart';

class EditProfileViewModel extends ChangeNotifier {
  final EditProfileRepository editProfileRepository;

  EditProfileViewModel(
    this.editProfileRepository,
  );

  Future editProfile({
    required String fName,
    required String lName,
    required String email,
    required File img,
  }) async {
    editProfileRepository.editProfile(
      fName: fName,
      lName: lName,
      email: email,
      img: img,
    );
    notifyListeners();
  }
}
