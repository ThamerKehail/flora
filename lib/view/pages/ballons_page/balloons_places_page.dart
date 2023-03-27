import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/balloons_banners.dart';
import 'package:ward/models/place_details_model.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/ballons_page/balloons_view_model.dart';
import 'package:ward/view/pages/ballons_page/search_balloons_page/search_balloon_page.dart';
import 'package:ward/view/widget/balloons_widget/balloons_widget.dart';
import '../../../models/all_places_model.dart';
import '../../../models/balloons.dart';
import '../../../utils/const.dart';
import '../../../utils/language_constant.dart';
import '../../widget/home_widget/carsousel.dart';
import '../cart_page/cart_view_model.dart';

class BalloonsPlaces extends StatefulWidget {
  const BalloonsPlaces({Key? key}) : super(key: key);

  @override
  State<BalloonsPlaces> createState() => _BalloonsPlacesState();
}

class _BalloonsPlacesState extends State<BalloonsPlaces> {
  @override
  Widget build(BuildContext context) {
    final balloons = context.watch<BalloonsPlacesViewModel>();
    balloons.placesNearMe.clear();
    balloons.bannerImg.clear();

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
                  balloons.adminArea ?? "",
                  style: const TextStyle(
                    fontSize: 18,
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
                        context: context, delegate: SearchBalloonsPlaces());
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
              FutureBuilder<List<BalloonsBannerModel>>(
                  future: balloons.banners,
                  builder: (context, snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var products = snapshot.data!;

                    for (var element in products) {
                      balloons.bannerImg.add(
                          "http://www.florajo.com/assets/img/banner/${element.bannerImg}");
                    }
                    return CarouselWithDotsPage(
                      imgList: balloons.bannerImg,
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
                  future: balloons.balloons,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text(snapshot.error.toString());
                    }
                    // var products = snapshot.data!;
                    //
                    // for (var element in products) {
                    //   balloons.lat2 = element.lat;
                    //   balloons.lng = element.long;
                    //   balloons.calDistance(
                    //     double.tryParse('${balloons.lat2}'),
                    //     double.tryParse('${balloons.lng}'),
                    //   );
                    //   balloons.placesNearMe.add(
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
                    balloons.placesNearMe
                        .sort((a, b) => a.distance.compareTo(b.distance));

                    balloons.instantInfo.shuffle();

                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: balloons.resultBalloons!.length,
                        itemBuilder: (context, index) {
                          return BalloonsPlacesWidget(
                            allPlaces: balloons.resultBalloons![index],
                            // description: balloons
                            //     .placesNearMe[index].businessDescription,
                            // fname: balloons.placesNearMe[index].fname,
                            // city: balloons.placesNearMe[index].city,
                            // address: balloons.placesNearMe[index].address,
                            // id: balloons.placesNearMe[index].id,
                            // cover: balloons.placesNearMe[index].cover,
                            // from: balloons.placesNearMe[index].from.toString(),
                            // lName: balloons.placesNearMe[index].lname,
                            // profileImage:
                            //     balloons.placesNearMe[index].profileImage,
                            // to: balloons.placesNearMe[index].to.toString(),
                            // email: balloons.placesNearMe[index].email,
                          );
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
