import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlImages = [
      'https://w0.peakpx.com/wallpaper/434/522/HD-wallpaper-romantic-place-house-romantic-flowers-place-garden-walk-spring-alley-beautiful.jpg',
      "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg",
      'https://www.proflowers.com/blog/wp-content/uploads/2016/01/1-00_Types-of-Flowers_MainHero.png',
    ];
    return CarouselSlider(
        items: urlImages
            .map((e) => Image.network(
                  e,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ))
            .toList(),
        options: CarouselOptions(
            height: 120.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            viewportFraction: 3.0,
            autoPlayAnimationDuration: const Duration(seconds: 3),
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal));
  }
}
