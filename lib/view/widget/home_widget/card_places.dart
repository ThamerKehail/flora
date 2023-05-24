import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/data/api/business_color_api.dart';
import 'package:ward/data/repositories/business_color_repository.dart';
import 'package:ward/utils/global.dart';

import '../../../data/api/avg_business_rate.dart';
import '../../../data/api/package_api.dart';
import '../../../data/api/product_api.dart';
import '../../../data/repositories/avg_business_repository.dart';
import '../../../data/repositories/package_repository.dart';
import '../../../data/repositories/product_repositories.dart';
import '../../../dio/dio_client.dart';
import '../../pages/bouquet_details/bouquet_view_main.dart';
import '../../pages/store_page/store_page.dart';
import '../../pages/store_page/store_view_model.dart';
import '../../pages/wishlist_page/wishlist_view_model.dart';

class CardPlacesWidget extends StatelessWidget {
  final String name;
  final String img;
  final String description;
  final int from;
  final int to;
  final String address;
  final String cover;
  final double city;
  final int id;
  final String email;

  const CardPlacesWidget({
    Key? key,
    required this.name,
    required this.img,
    required this.id,
    required this.description,
    required this.from,
    required this.to,
    required this.address,
    required this.city,
    required this.cover,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
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
                                      ProductRepository(
                                          ProductApi(DioClient())),
                                      PackageRepository(
                                          PackageApi(DioClient())),
                                      AvgBusinessRepository(
                                          AvgBusinessApi(DioClient()))),
                                  child: StorePage(
                                    businessId: id,
                                    placeName: name,
                                    placeDescription: description,
                                    timeFrom: int.parse(
                                        from.toString().split(':')[0]),
                                    timeTo:
                                        int.parse(to.toString().split(':')[0]),
                                    address: address,
                                    city: city.toString(),
                                    cover: cover,
                                    email: email,
                                  ),
                                )),
                          )));
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: CachedNetworkImage(
                width: 124,
                height: 124,
                imageUrl: "$url/loge/$img",
                errorWidget: (BuildContext, String, dynamic) => Image.asset(
                  "assets/images/flora_cover.png",
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(name),
        ],
      ),
    );
  }
}
