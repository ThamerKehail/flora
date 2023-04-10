import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/data/api/business_color_api.dart';
import 'package:ward/data/repositories/business_color_repository.dart';
import 'package:ward/dio/dio_client.dart';
import 'package:ward/models/package_model.dart';
import 'package:ward/models/product_model.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/bouquet_details/bouquet_details.dart';
import 'package:ward/view/pages/bouquet_details/bouquet_view_main.dart';
import 'package:ward/view/pages/store_page/store_view_model.dart';
import 'package:ward/view/widget/store_widget/bouquet_widget.dart';
import 'package:ward/view/widget/store_widget/product_widget.dart';

import '../../pages/cart_page/cart_view_model.dart';

class DefaultTabBar extends StatefulWidget {
  final int businessId;
  final String businessEmail;
  const DefaultTabBar(
      {Key? key, required this.businessId, required this.businessEmail})
      : super(key: key);

  @override
  State<DefaultTabBar> createState() => _DefaultTabBarState();
}

class _DefaultTabBarState extends State<DefaultTabBar> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<StoresViewModel>().getAllProduct(widget.businessId));
    Future.microtask(
        () => context.read<StoresViewModel>().getAllPackage(widget.businessId));
  }

  List colors = <int>[];
  List colorsPackage = <int>[];

  @override
  Widget build(BuildContext context) {
    final products = context.watch<StoresViewModel>();
    final bouquet = Provider.of<CartViewModel>(context);

    return DefaultTabController(
        length: 2, // length of tabs
        initialIndex: 0,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          TabBar(
            labelColor: Colors.grey,
            unselectedLabelColor: Colors.black,
            indicatorColor: mainColor,
            tabs: [
              Tab(text: translation(context).bouquet),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Tab(text: translation(context).product),
                  const SizedBox(
                    width: 5,
                  ),
                  Center(
                    child: badge.Badge(
                      badgeStyle: badge.BadgeStyle(
                        badgeColor: mainColor,
                      ),
                      badgeContent: Consumer<CartViewModel>(
                        builder: (context, value, child) {
                          return Text(
                            value.itemBouquetCount.toString(),
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
                        Icons.card_giftcard,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
              height: 400, //height of TabBarView
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.5))),
              child: TabBarView(children: <Widget>[
                FutureBuilder<List<Product>>(
                    future: products.products,
                    builder: (context, snapshot) {
                      if (snapshot.hasError ||
                          snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Image.asset("assets/images/nproduct.png"),
                        );
                      }
                      colors.clear();
                      colors.isEmpty
                          ? snapshot.data![0].allProductsBus
                              ?.forEach((element) {
                              colors.add(element.color);
                              print(colors);
                            })
                          : null;

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: index == snapshot.data!.length - 1
                                ? EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).size.height * .3)
                                : EdgeInsets.only(bottom: 8),
                            child: ProductWidget(
                              product: snapshot.data![index],
                              index: index,
                              businessEmail: widget.businessEmail,
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    }),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    FutureBuilder<List<Package>>(
                        future: products.packages,
                        builder: (context, snapshot) {
                          if (snapshot.hasError ||
                              snapshot.connectionState !=
                                  ConnectionState.done) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Image.asset("assets/images/nproduct.png"),
                            );
                          }
                          colorsPackage.isEmpty
                              ? snapshot.data![0].allPackageBus
                                  ?.forEach((element) {
                                  colorsPackage.add(element.color);
                                })
                              : null;

                          return ListView.builder(
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: BouquetWidget(
                                        package: snapshot.data![i],
                                        index: i,
                                        colors: colors,
                                        email: widget.businessEmail,
                                      )),
                                  i == snapshot.data!.length - 1
                                      ? const SizedBox(
                                          height: 50,
                                        )
                                      : const SizedBox(
                                          height: 1,
                                        ),
                                ],
                              );
                            },
                            itemCount: snapshot.data!.length,
                          );
                        }),
                    bouquet.bouquetList.isEmpty
                        ? SizedBox()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Material(
                                borderRadius: BorderRadius.circular(15),
                                elevation: 12,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider(
                                                  create: (_) => BouquetViewModel(
                                                      BusinessColorRepository(
                                                          BusinessColorApi(
                                                              DioClient()))),
                                                  child: BouquetDetails(
                                                    colors: colorsPackage,
                                                    businessId:
                                                        widget.businessId,
                                                  ),
                                                )));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 0),
                                      height: 65,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            translation(context).myBouquet,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 35,
                                          )
                                        ],
                                      )),
                                )),
                          ),
                  ],
                ),
              ]))
        ]));
  }
}
