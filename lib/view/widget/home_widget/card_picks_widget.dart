import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class CardPicksWidget extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;
  const CardPicksWidget(
      {Key? key, required this.image, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: mainColor,
            ),
            child: Center(
              child: Image.asset(
                image,
                width: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(text, textAlign: TextAlign.center),
      ],
    );
  }
}
