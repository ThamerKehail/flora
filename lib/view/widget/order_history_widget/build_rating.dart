import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../utils/const.dart';

class BuildRating extends StatefulWidget {
  const BuildRating({Key? key}) : super(key: key);

  @override
  State<BuildRating> createState() => _BuildRatingState();
}

class _BuildRatingState extends State<BuildRating> {
  @override
  Widget build(BuildContext context) {
    double rating = 0;
    return RatingBar.builder(
      initialRating: rating,
      maxRating: 1,
      updateOnDrag: true,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rate) => setState(() {
        rating = rate;
      }),
    );
  }
}
