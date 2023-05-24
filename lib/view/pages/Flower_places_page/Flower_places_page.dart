import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/flowers_banners.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/Flower_places_page/Flower_places_view_model.dart';
import 'package:ward/view/pages/Flower_places_page/search_page/search_page.dart';
import 'package:ward/view/widget/balloons_widget/balloons_widget.dart';

import '../../../models/all_places_model.dart';
import '../../../utils/global.dart';
import '../../../utils/language_constant.dart';
import '../../widget/home_widget/carsousel.dart';
import '../cart_page/cart_view_model.dart';

class FlowerPlaces extends StatefulWidget {
  const FlowerPlaces({Key? key}) : super(key: key);

  @override
  State<FlowerPlaces> createState() => _FlowerPlacesState();
}

class _FlowerPlacesState extends State<FlowerPlaces> {
  @override
  Widget build(BuildContext context) {
    final flowers = context.watch<FlowerPlacesViewModel>();
    flowers.placesNearMe.clear();
    flowers.bannerImg.clear();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Text(translation(context).flowerPlace),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.cartScreen),
                  child: badge.Badge(
                    badgeStyle: badge.BadgeStyle(
                      badgeColor: mainColor,
                    ),
                    badgeContent: Consumer<CartViewModel>(
                      builder: (context, value, child) {
                        return Text(
                          value.itemCount.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    badgeAnimation: badge.BadgeAnimation.slide(
                      disappearanceFadeAnimationDuration:
                          Duration(milliseconds: 300),
                      // curve: Curves.easeInCubic,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchPlaces());
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),

      // AppBar(
      //   backgroundColor: mainColor,
      //   title: Text("Flower Places"),
      //   centerTitle: true,
      //   elevation: 0.0,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<FlowersBannerModel>>(
                  future: flowers.banners,
                  builder: (context, snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var products = snapshot.data!;

                    for (var element in products) {
                      flowers.bannerImg.add("$url/${element.bannerImg}");
                    }
                    return CarouselWithDotsPage(
                      imgList: flowers.bannerImg,
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
                  future: flowers.places,
                  builder: (context, snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var products = snapshot.data!;

                    // for (var element in products) {
                    //   flowers.lat2 = element.lat;
                    //   flowers.lng = element.long;
                    //   flowers.calDistance(
                    //     double.tryParse('${flowers.lat2}'),
                    //     double.tryParse('${flowers.lng}'),
                    //   );
                    //   flowers.placesNearMe.add(
                    //     PlaceDetailsModel(
                    //       fname: element.fname!,
                    //       address: element.address!,
                    //       lname: element.lName!,
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
                    flowers.placesNearMe
                        .sort((a, b) => a.distance.compareTo(b.distance));

                    flowers.instantInfo.shuffle();

                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: flowers.resultPlaces!.length,
                        itemBuilder: (context, index) {
                          return BalloonsPlacesWidget(
                            // description:
                            //     flowers.placesNearMe[index].businessDescription,
                            // fname: flowers.placesNearMe[index].fname,
                            // city: flowers.placesNearMe[index].city,
                            // address: flowers.placesNearMe[index].address,
                            // id: flowers.placesNearMe[index].id,
                            // cover: flowers.placesNearMe[index].cover,
                            // from: flowers.placesNearMe[index].from.toString(),
                            // lName: flowers.placesNearMe[index].lname,
                            // profileImage:
                            //     flowers.placesNearMe[index].profileImage,
                            // to: flowers.placesNearMe[index].to.toString(),
                            // email: flowers.placesNearMe[index].email,
                            allPlaces: flowers.resultPlaces![index],
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
