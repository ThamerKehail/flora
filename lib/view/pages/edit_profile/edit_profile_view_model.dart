import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/data/repositories/edit_profile_repository.dart';
import 'package:ward/models/user_model.dart';

import 'package:http/http.dart' as http;

class EditProfileViewModel extends ChangeNotifier {
  final EditProfileRepository editProfileRepository;

  EditProfileViewModel(
    this.editProfileRepository,
  );
  File? imageData;
  bool dataLoaded = false;

  downloadAndSavePhoto(String url) async {
    // Get file from internet
    var response = await http.get(Uri.parse(url)); //%%%
    // documentDirectory is the unique device path to the area you'll be saving in
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/images"; //%%%
    //You'll have to manually create subdirectories
    await Directory(firstPath).create(recursive: true); //%%%
    // Name the file, create the file, and save in byte form.
    var filePathAndName = documentDirectory.path + '/images/pic.jpg';
    File file2 = new File(filePathAndName); //%%%
    file2.writeAsBytesSync(response.bodyBytes); //%%%
    imageData = file2;

    print(imageData);
    dataLoaded = true;
    notifyListeners();
  }

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
