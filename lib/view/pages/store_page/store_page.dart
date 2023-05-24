import 'package:badges/badges.dart' as badge;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/global.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/cart_page/cart_view_model.dart';
import 'package:ward/view/pages/store_page/store_view_model.dart';
import 'package:ward/view/widget/store_widget/tabbar_widget.dart';

import '../../../models/avg_business_rate.dart';
import '../../widget/full_screen.dart';

class StorePage extends StatefulWidget {
  final int? businessId;
  final String? placeName;
  final String? placeDescription;
  final String? city;
  final String? address;
  final String? cover;
  final int? timeFrom;
  final int? timeTo;
  final String email;
  const StorePage({
    Key? key,
    this.businessId,
    this.placeName,
    this.placeDescription,
    this.city,
    this.address,
    this.timeFrom,
    this.timeTo,
    this.cover,
    required this.email,
  }) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        context.read<StoresViewModel>().getAvgBusiness(widget.businessId!));
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DetailScreen(
                            image: '$url/${widget.cover}',
                          )));
                },
                child: CachedNetworkImage(
                  width: 124,
                  height: 124,
                  imageUrl: "$url/${widget.cover}",
                  errorWidget: (BuildContext, String, dynamic) => Image.asset(
                    "assets/images/flora_cover.png",
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            floating: true,
            pinned: true,
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                    size: 25,
                  )),
            ),
            actions: [
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.cartScreen),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
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
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
          _buildBody(
            placeName: widget.placeName ?? "PlaceName not  found",
            placeDescription:
                widget.placeDescription ?? "PlaceDescription not  found",
            city: widget.city ?? "city",
            address: widget.address ?? "address",
            time: now.hour,
            timeFrom: widget.timeFrom ?? 0,
            timeTo: widget.timeTo ?? 0,
          ),
        ],
      ),
    );
  }

  Widget _buildBody({
    required String placeName,
    required String placeDescription,
    required String city,
    required String address,
    required int time,
    required int timeFrom,
    required int timeTo,
  }) {
    final store = context.watch<StoresViewModel>();
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<AvgBusinessRate>(
                      future: store.avg,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              placeName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            (snapshot.hasData)
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        snapshot.data!.rate.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        );
                      }),
                  Text(
                    placeDescription,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined, color: Colors.grey),
                          Text(
                            (time >= timeFrom && time < timeTo)
                                ? 'Open'
                                : 'Close',
                            style: TextStyle(
                              color: (time >= timeFrom && time < timeTo)
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              color: Colors.grey),
                          Text(
                            address,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            color: mainColor,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            '$city JD',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            DefaultTabBar(
              businessId: widget.businessId!,
              businessEmail: widget.email,
            )
          ],
        ),
      ),
    );
  }
}
