import 'package:flutter/material.dart';
import 'package:ward/utils/theme.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/flora_cover.png"),
            const SizedBox(
              height: 35,
            ),
            const Center(
              child: Text(
                "About Us",
                style: TextStyle(
                  color: Color(0xff166d5d),
                  fontSize: 35,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "The first Jordanian application that brings together the best gift shops, flowers, and balloon arrangements in one place, so that you can enjoy the largest possible number of options, which saves you time and effort in searching for the right gift. thank you for your trust .",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: mainColor,
                        ),
                        child: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "962 7 9935 0099",
                        style: TextStyle(
                          color: Color(0xff166d5d),
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: mainColor,
                        ),
                        child: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: const Text(
                          "Flora.jo962@gmail.com",
                          style: TextStyle(
                            color: Color(0xff166d5d),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
