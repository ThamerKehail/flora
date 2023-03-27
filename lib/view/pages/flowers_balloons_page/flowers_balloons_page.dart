import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/flowers_balloons_banner_model.dart';
import 'package:ward/models/place_details_model.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/flowers_balloons_page/search_flowers_balloons_page/search_flower_balloons_page.dart';
import 'package:ward/view/widget/balloons_widget/balloons_widget.dart';
import '../../../models/all_places_model.dart';
import '../../../models/flowers_balloons_model.dart';
import '../../../utils/const.dart';
import '../../../utils/language_constant.dart';
import '../../widget/home_widget/carsousel.dart';
import '../cart_page/cart_view_model.dart';
import 'flowers_balloons_view_model.dart';

class FlowerAndBalloonsPlaces extends StatefulWidget {
  const FlowerAndBalloonsPlaces({Key? key}) : super(key: key);

  @override
  State<FlowerAndBalloonsPlaces> createState() =>
      _FlowerAndBalloonsPlacesState();
}

class _FlowerAndBalloonsPlacesState extends State<FlowerAndBalloonsPlaces> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(
    //     () => context.read<FlowerAndBalloonsPlacesViewModel>().getAllPlaces());
    // Future.microtask(
    //     () => context.read<FlowerAndBalloonsPlacesViewModel>().getAllBanner());
    // Future.microtask(
    //     () => context.read<FlowerAndBalloonsPlacesViewModel>().getLocation());
    // Future.microtask(() =>
    //     context.read<FlowerAndBalloonsPlacesViewModel>().placesNearMe.clear());
    // Future.microtask(() =>
    //     context.read<FlowerAndBalloonsPlacesViewModel>().bannerImg.clear());
  }

  @override
  Widget build(BuildContext context) {
    final flowersBalloons = context.watch<FlowerAndBalloonsPlacesViewModel>();
    flowersBalloons.placesNearMe.clear();
    flowersBalloons.bannerImg.clear();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Column(
              children: [
                Text(
                  translation(context).deliveredTo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  flowersBalloons.adminArea ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
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
                    showSearch(
                        context: context,
                        delegate: SearchFlowersBalloonsPlaces());
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<FlowersBalloonsBannerModel>>(
                  future: flowersBalloons.banners,
                  builder: (context, snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var products = snapshot.data!;

                    for (var element in products) {
                      flowersBalloons.bannerImg.add(
                          "http://www.florajo.com//assets/img/banner/${element.bannerImg}");
                    }
                    return CarouselWithDotsPage(
                      imgList: flowersBalloons.bannerImg,
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
                  future: flowersBalloons.places,
                  builder: (context, snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var products = snapshot.data!;

                    // for (var element in products) {
                    //   flowersBalloons.lat2 = element.lat;
                    //   flowersBalloons.lng = element.long;
                    //   flowersBalloons.calDistance(
                    //     double.tryParse('${flowersBalloons.lat2}'),
                    //     double.tryParse('${flowersBalloons.lng}'),
                    //   );
                    //   flowersBalloons.placesNearMe.add(
                    //     PlaceDetailsModel(
                    //       fname: element.fname!,
                    //       address: element.address!,
                    //       lname: element.lname ?? "",
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
                    flowersBalloons.placesNearMe
                        .sort((a, b) => a.distance.compareTo(b.distance));

                    flowersBalloons.instantInfo.shuffle();

                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: flowersBalloons.resultPlaces!.length,
                        itemBuilder: (context, index) {
                          return BalloonsPlacesWidget(
                            // description: flowersBalloons
                            //     .placesNearMe[index].businessDescription,
                            // fname: flowersBalloons.placesNearMe[index].fname,
                            // city: flowersBalloons.placesNearMe[index].city,
                            // address:
                            //     flowersBalloons.placesNearMe[index].address,
                            // id: flowersBalloons.placesNearMe[index].id,
                            // cover: flowersBalloons.placesNearMe[index].cover,
                            // from: flowersBalloons.placesNearMe[index].from
                            //     .toString(),
                            // lName: flowersBalloons.placesNearMe[index].lname,
                            // profileImage: flowersBalloons
                            //     .placesNearMe[index].profileImage,
                            // to: flowersBalloons.placesNearMe[index].to
                            //     .toString(),
                            // email: flowersBalloons.placesNearMe[index].email,
allPlaces: flowersBalloons.resultPlaces![index],

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
