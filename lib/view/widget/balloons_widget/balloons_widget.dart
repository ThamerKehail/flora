import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/data/api/business_color_api.dart';
import 'package:ward/data/repositories/business_color_repository.dart';
import 'package:ward/models/all_places_model.dart';
import 'package:ward/utils/const.dart';
import 'package:ward/utils/theme.dart';

import '../../../data/api/add_to_wishlist_api.dart';
import '../../../data/api/avg_business_rate.dart';
import '../../../data/api/delete_wishlist_item_api.dart';
import '../../../data/api/package_api.dart';
import '../../../data/api/product_api.dart';
import '../../../data/api/wishlist_product_api.dart';
import '../../../data/repositories/add_to_wishlist_repository.dart';
import '../../../data/repositories/avg_business_repository.dart';
import '../../../data/repositories/delete_wishlist_item_repository.dart';
import '../../../data/repositories/package_repository.dart';
import '../../../data/repositories/product_repositories.dart';
import '../../../data/repositories/wishlist_product_repository.dart';
import '../../../dio/dio_client.dart';
import '../../pages/bouquet_details/bouquet_view_main.dart';
import '../../pages/store_page/store_page.dart';
import '../../pages/store_page/store_view_model.dart';
import '../../pages/wishlist_page/wishlist_view_model.dart';

class BalloonsPlacesWidget extends StatelessWidget {
  // final String fname;
  // final String lName;
  // final String description;
  // final int id;
  // final String from;
  // final String to;
  // final String address;
  // final String cover;
  // final String profileImage;
  //
  // final double city;
  // final String email;
  final AllPlaces allPlaces;
//end
  const BalloonsPlacesWidget({
    Key? key,
    // required this.fname,
    // required this.lName,
    // required this.description,
    // required this.id,
    // required this.from,
    // required this.to,
    // required this.address,
    // required this.cover,
    // required this.profileImage,
    // required this.city,
    // required this.email,
    required this.allPlaces,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (_) => WishlistViewModel(),
                        child: ChangeNotifierProvider(
                            create: (_) => BouquetViewModel(
                                BusinessColorRepository(
                                    BusinessColorApi(DioClient()))),
                            child: ChangeNotifierProvider(
                              create: (_) => StoresViewModel(
                                  ProductRepository(ProductApi(DioClient())),
                                  PackageRepository(PackageApi(DioClient())),
                                  AvgBusinessRepository(
                                      AvgBusinessApi(DioClient()))),
                              child: StorePage(
                                businessId: allPlaces.id,
                                placeName: allPlaces.fname,
                                placeDescription: allPlaces.businessDescription,
                                timeFrom: int.parse(
                                    allPlaces.from.toString().split(':')[0]),
                                timeTo: int.parse(
                                    allPlaces.to.toString().split(':')[0]),
                                address: allPlaces.address,
                                city: allPlaces.city.toString(),
                                cover: allPlaces.cover.toString(),
                                email: allPlaces.email.toString(),
                              ),
                            )),
                      )));
        },
        child: Container(
          width: double.infinity,
          height: 230,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              )),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      // image: DecorationImage(
                      //     image: NetworkImage('$url/${allPlaces.cover}'),
                      //     fit: BoxFit.cover),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xff2D81EA),
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          width: 124,
                          height: 124,
                          imageUrl: "$url/${allPlaces.cover}",
                          errorWidget: (BuildContext, String, dynamic) =>
                              Image.asset(
                            "assets/images/flora_cover.png",
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allPlaces.fname! + allPlaces.lname.toString() ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(allPlaces.address!),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer_outlined,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  (now.hour >=
                                              int.parse(allPlaces.from
                                                  .toString()
                                                  .split(':')[0]) &&
                                          now.hour <
                                              int.parse(allPlaces.to
                                                  .toString()
                                                  .split(':')[0]))
                                      ? "Open"
                                      : 'Close',
                                  style: TextStyle(
                                    color: (now.hour >=
                                                int.parse(allPlaces.from
                                                    .toString()
                                                    .split(':')[0]) &&
                                            now.hour <
                                                int.parse(allPlaces.to
                                                    .toString()
                                                    .split(':')[0]))
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.delivery_dining,
                                  size: 22,
                                  color: mainColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${allPlaces.city.toString()} JD',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 25,
                right: 5,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CachedNetworkImage(
                    width: 124,
                    height: 124,
                    imageUrl: '$url/${allPlaces.profileImage}',
                    errorWidget: (BuildContext, String, dynamic) => Image.asset(
                      "assets/images/flora_logo.png",
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
