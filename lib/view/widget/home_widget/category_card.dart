import 'package:flutter/material.dart';
import 'package:ward/utils/routes.dart';

import '../../../utils/theme.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String text;
  final Color textColor;
  final Color cardColor;
  final int index;
  const CategoryCard({
    Key? key,
    required this.image,
    required this.text,
    required this.textColor,
    required this.cardColor,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * .15,
      ),
      child: InkWell(
          onTap: () {
            index == 0
                ? Navigator.of(context).pushNamed(AppRoutes.flowersPlacesScreen)
                : (index == 1)
                    ? Navigator.of(context)
                        .pushNamed(AppRoutes.balloonsPlacesScreen)
                    : Navigator.of(context)
                        .pushNamed(AppRoutes.flowersAndBalloonsPlacesScreen);
          },
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.contain,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(text),
            ],
          )

          // Container(
          //   height: 80,
          //   width: 220,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15),
          //     color: cardColor,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Image.network(
          //         image,
          //         height: 70,
          //         width: 85,
          //       ),
          //       const SizedBox(
          //         width: 5,
          //       ),
          //       Text(
          //         text,
          //         style: TextStyle(
          //           color: textColor,
          //           fontSize: 20,
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
