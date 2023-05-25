import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/hex_color.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/view/pages/bouquet_details/bouquet_view_main.dart';
import 'package:ward/view/pages/cart_bouquet_page/cart_bouquet_page.dart';
import 'package:ward/view/pages/cart_page/cart_view_model.dart';
import 'package:ward/view/pages/product_details_page/product_details_view_model.dart';
import 'package:ward/view/widget/product_details/color_picker.dart';

import '../../../models/bouquet.dart';
import '../../../models/business_color_model.dart';
import '../../../utils/theme.dart';
import '../../widget/bouquet_widget/bouquet_widget.dart';
import '../../widget/product_details/radio_button.dart';

class BouquetDetails extends StatefulWidget {
  final List? colors;
  final int? businessId;
  const BouquetDetails({
    Key? key,
    this.colors,
    this.businessId,
  }) : super(key: key);

  @override
  State<BouquetDetails> createState() => _BouquetDetailsState();
}

class _BouquetDetailsState extends State<BouquetDetails> {
  final List<Color> colorSelected = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.brown,
    Colors.black,
    Colors.purple,
    Colors.yellow,
    Colors.brown,
    Colors.black,
    Colors.purple,
  ];
  int currentPage = 0;
  int currentColor = 0;
  TextEditingController messageTextController = TextEditingController();
  @override
  void initState() {
    Future.microtask(() => context
        .read<BouquetViewModel>()
        .getAllColors(businessId: widget.businessId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bouquet = Provider.of<CartViewModel>(context);
    final bouquetDetails = context.watch<BouquetViewModel>();
    final productsDetails = context.watch<ProductDetailsViewModel>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text(translation(context).myBoq),
          centerTitle: true,
        ),
        body: bouquet.bouquetList.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset("assets/images/nproduct.png"),
                  ),
                ],
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translation(context).allChoose,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return BouquetWidget(
                                qty: bouquet.bouquetList.values
                                    .toList()[index]
                                    .quantity,
                                image: bouquet.bouquetList.values
                                    .toList()[index]
                                    .image,
                                price: bouquet.bouquetList.values
                                    .toList()[index]
                                    .productPrice,
                                name: bouquet.bouquetList.values
                                    .toList()[index]
                                    .productName,
                                packageId:
                                    bouquet.bouquetList.keys.toList()[index],
                                id: bouquet.bouquetList.values
                                    .toList()[index]
                                    .id,
                                initPrice: bouquet.bouquetList.values
                                    .toList()[index]
                                    .productPrice,
                              );
                            },
                            itemCount: bouquet.bouquetList.length,
                          ),
                        ),

                        // FutureBuilder(
                        //     future: bouquet.getData(),
                        //     builder:
                        //         (context, AsyncSnapshot<List<Bouquet>> snapshot) {
                        //       if (snapshot.hasData) {
                        //         if (snapshot.data!.isEmpty) {
                        //           return Column(
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Center(
                        //                 child:
                        //                     Image.asset("assets/images/nproduct.png"),
                        //               ),
                        //             ],
                        //           );
                        //         }
                        //         return SizedBox(
                        //           height: 300,
                        //           width: double.infinity,
                        //           child: ListView.builder(
                        //             scrollDirection: Axis.horizontal,
                        //             itemBuilder: (context, index) {
                        //               return BouquetWidget(
                        //                 qty: snapshot.data![index].quantity,
                        //                 image: snapshot.data![index].image,
                        //                 price: snapshot.data![index].productPrice,
                        //                 name: snapshot.data![index].productName,
                        //                 packageId: snapshot.data![index].productId,
                        //                 id: snapshot.data![index].id!,
                        //                 initPrice: snapshot.data![index].initialPrice,
                        //               );
                        //             },
                        //             itemCount: snapshot.data!.length,
                        //           ),
                        //         );
                        //       } else {
                        //         return const CircularProgressIndicator();
                        //       }
                        //     }),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${translation(context).price}: ${bouquet.totalBouquetAmount.toStringAsFixed(2)} JD",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        Text(
                          translation(context).chooseColor,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        // Container(
                        //   height: 75,
                        //   width: double.infinity,
                        //   padding: const EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(30)),
                        //   child: ListView.separated(
                        //       scrollDirection: Axis.horizontal,
                        //       itemBuilder: (context, index) {
                        //         return Column(
                        //           children: [
                        //             ColorPicker(
                        //               color: Colors.red,
                        //               outBorder: currentColor == index,
                        //             ),
                        //             Text(widget.colors![index].toString()),
                        //           ],
                        //         );
                        //       },
                        //       itemCount: widget.colors!.length,
                        //       separatorBuilder: (context, index) =>
                        //           const SizedBox(
                        //             height: 3,
                        //           )),
                        // ),
                        FutureBuilder<List<BusinessColors>>(
                            future: bouquetDetails.colors,
                            builder: (context, snapshot) {
                              if (snapshot.hasError ||
                                  snapshot.connectionState !=
                                      ConnectionState.done) {
                                print(snapshot.connectionState);
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.data!.isEmpty) {
                                return Center(
                                  child:
                                      Image.asset("assets/images/nproduct.png"),
                                );
                              }
                              return Container(
                                height: 75,
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: mainColor,
                                ),
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ColorPicker(
                                            index: index,
                                            color: HexColor.fromHex(
                                                '${snapshot.data![index].colorID}'),
                                            outBorder: currentColor == index,
                                            currentColor:
                                                snapshot.data![index].colorID,
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: snapshot.data!.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 3,
                                        )),
                              );
                            }),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          translation(context).message,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: messageTextController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: translation(context).enterMessage,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Material(
                            borderRadius: BorderRadius.circular(15),
                            elevation: 12,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => CartBouquetPage(
                                      currentColor:
                                          '${productsDetails.colorBouq}'
                                              .replaceFirst('#', ''),
                                      message: messageTextController.text),
                                ));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 17),
                                  height: 65,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        translation(context).addToCart,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                        size: 35,
                                      )
                                    ],
                                  )),
                            )),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
