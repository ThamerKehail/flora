import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/all_places_banner.dart';
import 'package:ward/models/all_places_model.dart';
import 'package:ward/models/place_details_model.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/all_places_page/all_places_view_model.dart';
import 'package:ward/view/pages/all_places_page/search_allPlaces_page/search_allPlaces_page.dart';
import 'package:ward/view/widget/balloons_widget/balloons_widget.dart';
import '../../../utils/const.dart';
import '../../../utils/language_constant.dart';
import '../../widget/home_widget/carsousel.dart';
import '../cart_page/cart_view_model.dart';

class AllPlacesPage extends StatefulWidget {
  const AllPlacesPage({Key? key}) : super(key: key);

  @override
  State<AllPlacesPage> createState() => _AllPlacesPageState();
}

class _AllPlacesPageState extends State<AllPlacesPage> {
  @override
  Widget build(BuildContext context) {
    final places = context.watch<AllPlacesViewModel>();
    places.placesNearMe.clear();
    places.bannerImg.clear();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "Flora",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<AllPlacesBannerModel>>(
                  future: places.banners,
                  builder: (context, snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var products = snapshot.data!;

                    for (var element in products) {
                      places.bannerImg.add("$url/${element.bannerImg}");
                    }
                    return CarouselWithDotsPage(
                      imgList: places.bannerImg,
                    );
                  }),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "${translation(context).all} ${translation(context).places}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),

              FutureBuilder<List<AllPlaces>>(
                  future: places.places,
                  builder: (context, snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var products = snapshot.data!;

                    // for (var element in products) {
                    //   places.lat2 = element.lat;
                    //   places.lng = element.long;
                    //   places.calDistance(
                    //     double.tryParse('${places.lat2}'),
                    //     double.tryParse('${places.lng}'),
                    //   );
                    //   places.placesNearMe.add(
                    //     PlaceDetailsModel(
                    //       fname: element.fname!,
                    //       address: element.address!,
                    //       lname: element.lname!,
                    //       long: element.long!,
                    //       lat: element.lat!,
                    //       profileImage: element.profileImage!,
                    //       to: element.to!,
                    //       from: element.from!,
                    //       cover: element.cover!,
                    //       id: element.id!,
                    //       businessDescription: element.businessDescription!,
                    //       city: element.city!,
                    //       distance: distanceKm,
                    //       email: element.email!,
                    //     ),
                    //   );
                    // }
                    // places.placesNearMe
                    //     .sort((a, b) => a.distance.compareTo(b.distance));

                    places.instantInfo.shuffle();

                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: places.resultBalloons!.length,
                        itemBuilder: (context, index) {
                          return BalloonsPlacesWidget(
                            // description: places
                            //     .resultBalloons![index].businessDescription!,
                            // fname: places.resultBalloons![index].fname!,
                            // city: places.resultBalloons![index].city!,
                            // address: places.resultBalloons![index].address!,
                            // id: places.resultBalloons![index].id!,
                            // cover: places.resultBalloons![index].cover!,
                            // from: places.resultBalloons![index].from.toString(),
                            // lName: places.resultBalloons![index].lname!,
                            // profileImage:
                            //     places.resultBalloons![index].profileImage!,
                            // to: places.resultBalloons![index].to.toString(),
                            // email: places.resultBalloons![index].email!,
                            allPlaces: places.resultBalloons![index],
                          );
                        });
                  })
              // ListView(
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   children: dummyPlaces
              //       .map((e) => Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: PlacesWidget(
              //               placesModel: e,
              //             ),
              //           ))
              //       .toList(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
