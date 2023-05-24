import 'package:flutter/material.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/theme.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: BackButton(),
    title: Text(translation(context).editProfile),
    centerTitle: true,
    backgroundColor: mainColor,
    elevation: 0,
  );
}
