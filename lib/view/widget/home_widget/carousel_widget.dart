import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWidget extends StatefulWidget {
  CarouselWidget({Key? key}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int activeIndex = 0;

  final urlImages = [
    "https://uaw.org/wp-content/uploads/2016/02/flowers_feb-1.jpg",
    "https://static-prod.adweek.com/wp-content/uploads/2020/02/FarmgirlFlowersFBCoverPhoto.jpg",
    "https://i.ytimg.com/vi/I24luYw6Eqg/maxresdefault.jpg",
    "https://uaw.org/wp-content/uploads/2016/02/flowers_feb-1.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider.builder(
            itemCount: urlImages.length,
            itemBuilder: (context, i, realIndex) {
              final urlImage = urlImages[i];
              return buildImage(urlImage, i);
            },
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              viewportFraction: 1,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              autoPlayInterval: const Duration(seconds: 2),
            )),
        const SizedBox(
          height: 10,
        ),
        buildIndicator(),
      ],
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.fitWidth,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex, count: urlImages.length);
}
