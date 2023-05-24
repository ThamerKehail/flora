// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:ward/models/home_model.dart';
// import 'package:ward/view/pages/home_all_data/home_all_data_view_model.dart';
//
// import '../../../data/api/add_to_wishlist_api.dart';
// import '../../../data/api/delete_wishlist_item_api.dart';
// import '../../../data/api/wishlist_product_api.dart';
// import '../../../data/repositories/add_to_wishlist_repository.dart';
// import '../../../data/repositories/delete_wishlist_item_repository.dart';
// import '../../../data/repositories/wishlist_product_repository.dart';
// import '../../../dio/dio_client.dart';
// import '../../../utils/global.dart';
// import '../../../utils/language_constant.dart';
// import '../../../utils/routes.dart';
// import '../../../utils/theme.dart';
// import '../../widget/home_widget/card_picks_widget.dart';
// import '../../widget/home_widget/carsousel.dart';
// import '../../widget/home_widget/category_card.dart';
// import '../wishlist_page/wishlist_page.dart';
// import '../wishlist_page/wishlist_view_model.dart';
//
// class HomeAllData extends StatefulWidget {
//   const HomeAllData({Key? key}) : super(key: key);
//
//   @override
//   State<HomeAllData> createState() => _HomeAllDataState();
// }
//
// class _HomeAllDataState extends State<HomeAllData> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.microtask(() => context.read<HomeAllDataViewModel>().getHomeData());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final homeModel = context.watch<HomeAllDataViewModel>();
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: SingleChildScrollView(
//             child: FutureBuilder<List<HomeModel>>(
//                 future: homeModel.home,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState != ConnectionState.done) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     print(snapshot.error);
//                     return Center(
//                       child: Text(snapshot.error.toString()),
//                     );
//                   }
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: double.infinity,
//                         child: Image.network(
//                           "http://www.florajo.com//assets/img/banner/{snapshot.data![0].image![0].bannerImg}",
//                           height: 100,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 45,
//                       ),
//                       Text(
//                         "{translation(context).hey}, {snapshot.data?[0].fname} {snapshot.data?[0].lname}",
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         height: 110,
//                         child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: 2,
//                             itemBuilder: (context, i) {
//                               return CategoryCard(
//                                 image:
//                                     '$url/categorys/{snapshot.data![i].banner![0].bannerImg}',
//                                 text: 'snapshot.data![i].categoryName',
//                                 textColor: mainColor,
//                                 cardColor: Colors.grey.withOpacity(0.2),
//                                 index: i,
//                               );
//                             }),
//                       ),
//                       const SizedBox(
//                         height: 35,
//                       ),
//                       Text(
//                         translation(context).topPicks,
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           CardPicksWidget(
//                             image: "assets/images/order.png",
//                             text:
//                                 "${translation(context).order} \n ${translation(context).history}",
//                             onTap: () {
//                               Navigator.of(context)
//                                   .pushNamed(AppRoutes.orderHistoryScreen);
//                             },
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           CardPicksWidget(
//                             image: "assets/images/wishlist.png",
//                             text: " ${translation(context).wishlist} \n ",
//                             onTap: () {},
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           CardPicksWidget(
//                             text:
//                                 "${translation(context).all} \n ${translation(context).places}",
//                             image: "assets/images/places.png",
//                             onTap: () {
//                               Navigator.of(context)
//                                   .pushNamed(AppRoutes.allPlacesScreen);
//                             },
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           CardPicksWidget(
//                             onTap: () {
//                               Navigator.of(context)
//                                   .pushNamed(AppRoutes.aboutUsScreen);
//                             },
//                             text:
//                                 "${translation(context).about} \n ${translation(context).us}",
//                             image: "assets/images/team.png",
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 35,
//                       ),
//                       CarouselWithDotsPage(
//                         imgList: ['homeModel.bannerImg'],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         translation(context).placeNear,
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 25,
//                       ),
//                       // SizedBox(
//                       //   height: 120,
//                       //   child: FutureBuilder<List<AllPlaces>>(
//                       //       future: places.places,
//                       //       builder: (context, snapshot) {
//                       //         if (snapshot.hasError ||
//                       //             snapshot.connectionState != ConnectionState.done) {
//                       //           return const Center(child: CircularProgressIndicator());
//                       //         }
//                       //         var products = snapshot.data!;
//                       //
//                       //         for (var element in products) {
//                       //           homeModel.lat2 = element.lat;
//                       //           homeModel.lng = element.long;
//                       //           homeModel.calDistance(
//                       //             double.tryParse('${homeModel.lat2}'),
//                       //             double.tryParse('${homeModel.lng}'),
//                       //           );
//                       //           homeModel.placesNearMe.add(
//                       //             PlaceDetailsModel(
//                       //               fname: element.fname!,
//                       //               address: element.address!,
//                       //               lname: element.lname!,
//                       //               long: element.long!,
//                       //               lat: element.lat!,
//                       //               profileImage: element.profileImage!,
//                       //               to: element.to!,
//                       //               from: element.from!,
//                       //               cover: element.cover!,
//                       //               id: element.id!,
//                       //               businessDescription: element.businessDescription!,
//                       //               city: element.city!,
//                       //               distance: distanceKm,
//                       //             ),
//                       //           );
//                       //         }
//                       //         homeModel.placesNearMe
//                       //             .sort((a, b) => a.distance.compareTo(b.distance));
//                       //
//                       //         homeModel.instantInfo.shuffle();
//                       //
//                       //         return ListView.builder(
//                       //             scrollDirection: Axis.horizontal,
//                       //             itemCount: homeModel.placesNearMe.length,
//                       //             itemBuilder: (context, i) {
//                       //               return CardPlacesWidget(
//                       //                 img: homeModel.placesNearMe[i].cover,
//                       //                 name:
//                       //                 "${homeModel.placesNearMe[i].fname} ${homeModel.placesNearMe[i].lname}",
//                       //                 to: homeModel.placesNearMe[i].to,
//                       //                 from: homeModel.placesNearMe[i].to,
//                       //                 id: homeModel.placesNearMe[i].id,
//                       //                 address: homeModel.placesNearMe[i].address,
//                       //                 city: homeModel.placesNearMe[i].city,
//                       //                 description:
//                       //                 homeModel.placesNearMe[i].businessDescription,
//                       //                 cover: homeModel.placesNearMe[i].cover,
//                       //               );
//                       //             });
//                       //       }),
//                       // )
//                     ],
//                   );
//                 }),
//           ),
//         ),
//       ),
//     );
//   }
// }
