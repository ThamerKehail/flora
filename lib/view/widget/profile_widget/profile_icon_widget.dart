import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class ProfileIconWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String text;
  const ProfileIconWidget(
      {Key? key, required this.onTap, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: mainColor,
              ),
              child: Center(
                child: Image.asset(
                  image,
                  width: 30,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
