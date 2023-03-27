import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ward/utils/theme.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: BackButton(),
    title: Text("Profile Page"),
    centerTitle: true,
    backgroundColor: mainColor,
    elevation: 0,
  );
}
