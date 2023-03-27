import 'package:flutter/material.dart';

class HashColor {
  static fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length <= 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('0xff', '#'));
    return int.parse(buffer.toString(), radix: 16);
  }
}
