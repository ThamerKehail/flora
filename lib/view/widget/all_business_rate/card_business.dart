import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/business_rated_model.dart';
import 'package:ward/utils/language_constant.dart';

import '../../../models/all_business_rate.dart';
import '../../../utils/global.dart';
import '../../pages/rate_all_business_screen/rate_all_business_view_model.dart';

class CardBusinessWidget extends StatefulWidget {
  final AllBusinessRate allBusinessRate;
  const CardBusinessWidget({Key? key, required this.allBusinessRate})
      : super(key: key);

  @override
  State<CardBusinessWidget> createState() => _CardHistoryWidgetState();
}

class _CardHistoryWidgetState extends State<CardBusinessWidget> {
  double rating = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => context.read<RateAllBusinessViewModel>().getAllBusinessRated());
  }

  @override
  Widget build(BuildContext context) {
    final business = context.watch<RateAllBusinessViewModel>();
    return (widget.allBusinessRate.ordersCheack!.isEmpty)
        ? const SizedBox()
        : Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            "$url/${widget.allBusinessRate.ordersCheack![0].cover}",
                          ),
                          fit: BoxFit.cover,
                        )
                        // borderRadius: BorderRadius.circular(15),
                        ),
                    // child: CachedNetworkImage(
                    //   width: 124,
                    //   height: 124,
                    //   imageUrl:
                    //       "$url/${widget.allBusinessRate.ordersCheack![0].cover}",
                    //   errorWidget: (BuildContext, String, dynamic) =>
                    //       Image.asset(
                    //     "assets/images/flora_cover.png",
                    //     fit: BoxFit.cover,
                    //   ),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.allBusinessRate.ordersCheack![0].fname!} ${widget.allBusinessRate.ordersCheack?[0].lname ?? ""}',
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // Text(
                          //   "Description: ${widget.allBusinessRate.ordersCheack![0].businessDescription}  ",
                          //   style: const TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 18,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder<List<BusinessRated>>(
                      future: business.businessRated,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        return (snapshot.data!.indexWhere((element) =>
                                        element.orderId ==
                                        widget.allBusinessRate.orderId) ==
                                    -1 ||
                                snapshot.data!.isEmpty)
                            ? Column(
                                children: [
                                  rating.toInt() == 0
                                      ? TextButton(
                                          onPressed: () =>
                                              showRating(onTap: () {
                                                business.rate(
                                                  businessId: widget
                                                      .allBusinessRate
                                                      .ordersCheack![0]
                                                      .id!,
                                                  rating: rating.toInt(),
                                                );

                                                Navigator.pop(context);
                                              }),
                                          child: Text(
                                            translation(context).rateStore,
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ))
                                      : ElevatedButton(
                                          onPressed: () {
                                            business.rate(
                                                businessId: widget
                                                    .allBusinessRate
                                                    .businessId!,
                                                rating: rating.toInt());
                                            business
                                                .checkBusiness(
                                                    orderId: widget
                                                        .allBusinessRate
                                                        .orderId!)
                                                .whenComplete(() =>
                                                    Navigator.pop(context));
                                          },
                                          child: Text(
                                              translation(context).sendRate)),
                                ],
                              )
                            : Text(translation(context).thankRate);
                      }),
                ],
              ),
            ),
          );
  }

  // void showRating() {
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Text("Rate This App"),
  //             content: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 const Text("Please Rate This Product"),
  //                 const SizedBox(
  //                   height: 32,
  //                 ),
  //                 buildRating(),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                   onPressed: () {
  //                     rate.rate(
  //                       productId: widget.orders.productId!,
  //                       businessId: widget.orders.businessId!,
  //                       rating: rating.toInt(),
  //                     );
  //
  //                     Navigator.pop(context);
  //                   },
  //                   child: const Text("OK"))
  //             ],
  //           ));
  // }
  void showRating({required void Function() onTap}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(translation(context).rate),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(translation(context).rateProduct),
                  const SizedBox(
                    height: 32,
                  ),
                  buildRating(),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: onTap, child: Text(translation(context).oK))
              ],
            ));
  }

  Widget buildRating() {
    final rate = context.watch<RateAllBusinessViewModel>();
    return RatingBar.builder(
        maxRating: 0,
        initialRating: rating,
        itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
        allowHalfRating: false,
        updateOnDrag: true,
        onRatingUpdate: (rating) => setState(() {
              this.rating = rating;
            }));
  }
}
