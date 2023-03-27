import 'package:flutter/material.dart';

class TextUtils extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextDecoration? underLine;
  const TextUtils(
      {Key? key,
      required this.fontWeight,
      required this.text,
      required this.color,
      required this.fontSize,
      this.underLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: underLine),
    );
  }
}
