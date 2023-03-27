import 'package:flutter/material.dart';

import '../../../utils/theme.dart';
import '../text_utils.dart';

class ContainerUnder extends StatelessWidget {
  final String text;
  final String textType;
  final Function() onPressed;
  const ContainerUnder(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.textType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: mainColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextUtils(
            fontWeight: FontWeight.normal,
            text: text,
            color: Colors.white,
            fontSize: 15,
          ),
          TextButton(
            onPressed: onPressed,
            child: TextUtils(
              fontWeight: FontWeight.bold,
              text: textType,
              color: Colors.white,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
