import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/banner.dart';
import 'package:ward/models/category_model.dart';
import 'package:ward/models/home_image.dart';
import 'package:ward/utils/global.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/wishlist_page/wishlist_page.dart';
import 'package:ward/view/pages/wishlist_page/wishlist_view_model.dart';
import 'package:ward/view/widget/home_widget/card_picks_widget.dart';
import 'package:ward/view/widget/home_widget/category_card.dart';

import '../../../models/user_model.dart';
import '../../widget/home_widget/carsousel.dart';
import '../Flower_places_page/Flower_places_view_model.dart';
import '../all_places_page/all_places_view_model.dart';
import '../ballons_page/balloons_view_model.dart';
import '../cart_page/cart_view_model.dart';
import '../flowers_balloons_page/flowers_balloons_view_model.dart';
import '../profile_page/profile_view_model.dart';
import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // isSetLocation == false
    //     ? null
    //     : Future.microtask(() => context.read<HomeViewModel>().getLocation());
    Future.microtask(() => context.read<HomeViewModel>().placesNearMe.clear());
    Future.microtask(() => context.read<HomeViewModel>().getAllCategory());
    Future.microtask(() => context.read<HomeViewModel>().getAllBanner());

    Future.microtask(() => context.read<HomeViewModel>().getHomeImage());
    Future.microtask(() => context.read<HomeViewModel>().placesNearMe.clear());
    Future.microtask(() => context.read<HomeViewModel>().bannerImg.clear());
    Future.microtask(() => context.read<AllPlacesViewModel>().getAllPlaces());
    Future.microtask(() => context.read<ProfileViewModel>().getUserInfo());
    //balloons_screen
    Future.microtask(
        () => context.read<BalloonsPlacesViewModel>().getAllPlaces());
    Future.microtask(
        () => context.read<BalloonsPlacesViewModel>().getAllBanner());

    Future.microtask(
        () => context.read<BalloonsPlacesViewModel>().placesNearMe.clear());
    Future.microtask(
        () => context.read<BalloonsPlacesViewModel>().bannerImg.clear());
    Future.microtask(() => context.read<CartViewModel>().getAllCartProducts());
    //flowers_places
    Future.microtask(
        () => context.read<FlowerPlacesViewModel>().getAllPlaces());
    Future.microtask(
        () => context.read<FlowerPlacesViewModel>().getAllBanner());

    Future.microtask(
        () => context.read<FlowerPlacesViewModel>().placesNearMe.clear());
    Future.microtask(
        () => context.read<FlowerPlacesViewModel>().bannerImg.clear());
    //flowers_balloons_places
    Future.microtask(
        () => context.read<FlowerAndBalloonsPlacesViewModel>().getAllPlaces());
    Future.microtask(
        () => context.read<FlowerAndBalloonsPlacesViewModel>().getAllBanner());

    Future.microtask(() =>
        context.read<FlowerAndBalloonsPlacesViewModel>().placesNearMe.clear());
    Future.microtask(() =>
        context.read<FlowerAndBalloonsPlacesViewModel>().bannerImg.clear());
    //All_places
    Future.microtask(() => context.read<AllPlacesViewModel>().getAllPlaces());
    Future.microtask(() => context.read<AllPlacesViewModel>().getAllBanner());

    Future.microtask(
        () => context.read<AllPlacesViewModel>().placesNearMe.clear());
    Future.microtask(
        () => context.read<AllPlacesViewModel>().bannerImg.clear());
  }

  @override
  Widget build(BuildContext context) {
    final homeModel = context.watch<HomeViewModel>();
    final places = context.watch<AllPlacesViewModel>();
    final user = context.watch<ProfileViewModel>();

    homeModel.placesNearMe.clear();
    homeModel.bannerImg.clear();

    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<List<HomeImage>>(
                    future: homeModel.homeImage,
                    builder: (context, snapshot) {
                      if (snapshot.hasError ||
                          snapshot.connectionState != ConnectionState.done) {
                        homeModel.isPageLoading;
                        return SizedBox();
                      }

                      return SizedBox(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: "$url/${snapshot.data![0].bannerImg}",
                          errorWidget: (BuildContext, String, dynamic) =>
                              Image.asset(
                            "assets/images/flora_cover.png",
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.cover,
                        ),
                        // Image.network(
                        //   "$url/${snapshot.data![0].bannerImg}",
                        //   fit: BoxFit.fitWidth,
                        // ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 45,
                      ),
                      FutureBuilder<List<Client>>(
                          future: user.user,
                          builder: (context, snapshot) {
                            print("***********************");

                            if (snapshot.hasError ||
                                snapshot.connectionState !=
                                    ConnectionState.done) {
                              return CircularProgressIndicator();
                            } else if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  translation(context).welcomeApp,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            } else if (snapshot.hasData) {
                              return Text(
                                "${translation(context).hey}, ${snapshot.data?[0].fname} ${snapshot.data?[0].lname}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return Text("");
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<List<CategoryModel>>(
                          future: homeModel.categories, // #1
                          builder: (context, snapshot) {
                            if (snapshot.hasError ||
                                snapshot.connectionState !=
                                    ConnectionState.done) {
                              homeModel.isPageLoading;
                              return SizedBox();
                            }

                            return SizedBox(
                              height: 110,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, i) {
                                    return CategoryCard(
                                      image:
                                          '$url/${snapshot.data![i].categoryBanner}',
                                      text: snapshot.data![i].categoryName,
                                      textColor: mainColor,
                                      cardColor: Colors.grey.withOpacity(0.2),
                                      index: i,
                                    );
                                  }),
                            );
                          }),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        translation(context).topPicks,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CardPicksWidget(
                            image: "assets/images/order.png",
                            text:
                                "${translation(context).order} \n ${translation(context).history}",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.orderHistoryScreen);
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CardPicksWidget(
                            image: "assets/images/wishlist.png",
                            text: " ${translation(context).wishlist} \n ",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                            create: (_) => WishlistViewModel(),
                                            child: const WishlistPage(),
                                          )));
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CardPicksWidget(
                            text:
                                "${translation(context).all} \n ${translation(context).places}",
                            image: "assets/images/places.png",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.allPlacesScreen);
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CardPicksWidget(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.aboutUsScreen);
                            },
                            text:
                                "${translation(context).about} \n ${translation(context).us}",
                            image: "assets/images/team.png",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      FutureBuilder<List<BannerModel>>(
                          future: homeModel.banners,
                          builder: (context, snapshot) {
                            print(DateTime.now());
                            if (snapshot.hasError ||
                                snapshot.connectionState !=
                                    ConnectionState.done) {
                              homeModel.isPageLoading;
                              return SizedBox();
                            }

                            var products = snapshot.data!;
                            for (var element in products) {
                              homeModel.bannerImg
                                  .add("$url/${element.bannerImg}");
                            }
                            print(DateTime.now());
                            return CarouselWithDotsPage(
                              imgList: homeModel.bannerImg,
                            );
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      //place NearMe
                      // Text(
                      //   translation(context).placeNear,
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 22,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      // SizedBox(
                      //   height: 120,
                      //   child: FutureBuilder<List<AllPlaces>>(
                      //       future: places.places,
                      //       builder: (context, snapshot) {
                      //         if (snapshot.hasError ||
                      //             snapshot.connectionState !=
                      //                 ConnectionState.done) {
                      //           homeModel.isPageLoading;
                      //           return SizedBox();
                      //         }
                      //         // var products = snapshot.data!;
                      //
                      //         // for (var element in products) {
                      //         //   homeModel.lat2 = element.lat;
                      //         //   homeModel.lng = element.long;
                      //         //
                      //         //   homeModel.calDistance(
                      //         //     double.tryParse('${homeModel.lat2}'),
                      //         //     double.tryParse('${homeModel.lng}'),
                      //         //   );
                      //         //   homeModel.placesNearMe.add(
                      //         //     PlaceDetailsModel(
                      //         //       fname: element.fname!,
                      //         //       address: element.address!,
                      //         //       lname: element.lname!,
                      //         //       long: element.long!,
                      //         //       lat: element.lat!,
                      //         //       profileImage: element.profileImage!,
                      //         //       to: element.to!,
                      //         //       from: element.from!,
                      //         //       cover: element.cover!,
                      //         //       id: element.id!,
                      //         //       businessDescription:
                      //         //           element.businessDescription!,
                      //         //       city: element.city!,
                      //         //       distance: distanceKm,
                      //         //       email: element.email!,
                      //         //     ),
                      //         //   );
                      //         // }
                      //         homeModel.placesNearMe.sort(
                      //             (a, b) => a.distance.compareTo(b.distance));
                      //
                      //         homeModel.instantInfo.shuffle();
                      //         //homeModel.pageIsLoaded();
                      //         return ListView.builder(
                      //             scrollDirection: Axis.horizontal,
                      //             itemCount: homeModel.placesNearMe.length,
                      //             itemBuilder: (context, i) {
                      //               return CardPlacesWidget(
                      //                 img: homeModel.placesNearMe[i].cover,
                      //                 name:
                      //                     "${homeModel.placesNearMe[i].fname} ${homeModel.placesNearMe[i].lname}",
                      //                 to: homeModel.placesNearMe[i].to,
                      //                 from: homeModel.placesNearMe[i].to,
                      //                 id: homeModel.placesNearMe[i].id,
                      //                 address:
                      //                     homeModel.placesNearMe[i].address,
                      //                 city: homeModel.placesNearMe[i].city,
                      //                 description: homeModel
                      //                     .placesNearMe[i].businessDescription,
                      //                 cover: homeModel.placesNearMe[i].cover,
                      //                 email: homeModel.placesNearMe[i].email,
                      //               );
                      //             });
                      //       }),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        homeModel.isPageLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox()
      ],
    ));
  }
}
