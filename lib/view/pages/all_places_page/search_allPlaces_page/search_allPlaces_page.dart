import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/view/pages/ballons_page/balloons_view_model.dart';
import 'package:ward/view/widget/balloons_widget/balloon_widget.dart';

import '../../../../models/all_places_model.dart';
import '../../../../models/balloons.dart';
import '../../../../models/places_model.dart';
import '../../../widget/all_places/all_places_widget.dart';
import '../../../widget/home_widget/places_widget.dart';
import '../all_places_view_model.dart';

class SearchAllPlacesPlaces extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text("Search Places"),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final allPlaces = context.watch<AllPlacesViewModel>();

    List filterPlaces = allPlaces.resultBalloons!
        .where((element) => element.fname!.startsWith(query))
        .toList();

    return FutureBuilder<List<AllPlaces>>(
        future: allPlaces.places,
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          var products = snapshot.data!;
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  query == '' ? snapshot.data!.length : filterPlaces.length,
              itemBuilder: (context, index) {
                return query == ''
                    ? AllPlacesWidget(placesModel: products[index])
                    : AllPlacesWidget(placesModel: filterPlaces[index]);
              });
        });
  }
}
