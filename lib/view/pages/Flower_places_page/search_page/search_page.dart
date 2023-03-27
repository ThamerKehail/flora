import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/view/pages/ballons_page/balloons_view_model.dart';

import '../../../../models/all_places_model.dart';
import '../../../../models/places_model.dart';
import '../../../widget/home_widget/places_widget.dart';
import '../Flower_places_view_model.dart';

class SearchPlaces extends SearchDelegate {
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
    final places = context.watch<FlowerPlacesViewModel>();

    List filterPlaces = places.resultPlaces!
        .where((element) => element.fname!.startsWith(query))
        .toList();

    return FutureBuilder<List<AllPlaces>>(
        future: places.places,
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
                    ? PlacesWidget(placesModel: products[index])
                    : PlacesWidget(placesModel: filterPlaces[index]);
              });
        });
  }
}
