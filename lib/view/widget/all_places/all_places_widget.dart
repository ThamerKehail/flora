import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/data/api/package_api.dart';
import 'package:ward/data/api/product_api.dart';
import 'package:ward/data/repositories/package_repository.dart';
import 'package:ward/data/repositories/product_repositories.dart';
import 'package:ward/dio/dio_client.dart';
import 'package:ward/models/all_places_model.dart';
import 'package:ward/utils/global.dart';
import 'package:ward/view/pages/bouquet_details/bouquet_view_main.dart';
import 'package:ward/view/pages/store_page/store_view_model.dart';

import '../../../data/api/avg_business_rate.dart';
import '../../../data/api/business_color_api.dart';
import '../../../data/repositories/avg_business_repository.dart';
import '../../../data/repositories/business_color_repository.dart';
import '../../../utils/language_constant.dart';
import '../../pages/store_page/store_page.dart';

class AllPlacesWidget extends StatelessWidget {
  AllPlaces placesModel;
  AllPlacesWidget({Key? key, required this.placesModel}) : super(key: key);

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
                      create: (_) => BouquetViewModel(BusinessColorRepository(
                          BusinessColorApi(DioClient()))),
                      child: ChangeNotifierProvider(
                        create: (_) => StoresViewModel(
                            ProductRepository(ProductApi(DioClient())),
                            PackageRepository(PackageApi(DioClient())),
                            AvgBusinessRepository(AvgBusinessApi(DioClient()))),
                        child: StorePage(
                          businessId: placesModel.id,
                          placeName: placesModel.fname,
                          placeDescription: placesModel.businessDescription,
                          city: placesModel.city.toString(),
                          address: placesModel.address,
                          timeFrom: int.parse(
                              placesModel.from.toString().split(':')[0]),
                          timeTo: int.parse(
                              placesModel.to.toString().split(':')[0]),
                          cover: placesModel.cover!,
                          email: placesModel.email!,
                        ),
                      ))));
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
                crossAxisAlignment: translation(context).localeName == 'en'
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Colors.green,
                          // image: DecorationImage(
                          //     image: NetworkImage(
                          //         '$url/loge/${placesModel.cover}'),
                          //     fit: BoxFit.cover),
                        ),
                        child: CachedNetworkImage(
                          width: 124,
                          height: 124,
                          imageUrl: "$url/${placesModel.cover}",
                          errorWidget: (BuildContext, String, dynamic) =>
                              Image.asset(
                            "assets/images/flora_cover.png",
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment:
                          translation(context).localeName == 'en'
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                      children: [
                        Text(
                          placesModel.fname!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(placesModel.address!),
                        Text(
                          (now.hour >=
                                      int.parse(placesModel.from
                                          .toString()
                                          .split(':')[0]) &&
                                  now.hour <
                                      int.parse(placesModel.to
                                          .toString()
                                          .split(':')[0]))
                              ? "Open"
                              : 'Close',
                          style: TextStyle(
                            color: (now.hour >=
                                        int.parse(placesModel.from
                                            .toString()
                                            .split(':')[0]) &&
                                    now.hour <
                                        int.parse(placesModel.to
                                            .toString()
                                            .split(':')[0]))
                                ? Colors.green
                                : Colors.red,
                          ),
                        )
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
                    imageUrl: "$url/${placesModel.profileImage!}",
                    errorWidget: (BuildContext, String, dynamic) => Image.asset(
                      "assets/images/flora_cover.png",
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
