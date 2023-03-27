import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class BalloonsCarouselWithDotsPage extends StatefulWidget {
  final List<String> imgList;

  const BalloonsCarouselWithDotsPage({
    Key? key,
    required this.imgList,
  }) : super(key: key);

  @override
  _CarouselWithDotsPageState createState() => _CarouselWithDotsPageState();
}

class _CarouselWithDotsPageState extends State<BalloonsCarouselWithDotsPage> {
  int _current = 1;

  final CarouselController _controller = CarouselController();

  List pict = [];
  int? count = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pict.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pict.clear();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList
        .map((item) => ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: 124,
                    height: 124,
                    imageUrl: item,
                    errorWidget: (BuildContext, String, dynamic) => Image.asset(
                      "assets/images/flora_cover.png",
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ))
        .toList();
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 3.0,
                  initialPage: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey
                                : mainColor)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
