import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String image;
  DetailScreen({required this.image});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        clipBehavior: Clip.none,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            width: 124,
            height: 124,
            imageUrl: image,
            errorWidget: (BuildContext, String, dynamic) => Image.asset(
              "assets/images/flora_cover.png",
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    //   Scaffold(
    //   body: GestureDetector(
    //     child: Container(
    //       height: double.infinity,
    //       width: double.infinity,
    //       child: Image.network(
    //         image,
    //       ),
    //     ),
    //     onTap: () {
    //       Navigator.pop(context);
    //     },
    //   ),
    // );
  }
}
