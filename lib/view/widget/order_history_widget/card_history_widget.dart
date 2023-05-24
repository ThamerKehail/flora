import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/order_history.dart';
import 'package:ward/utils/global.dart';
import 'package:ward/view/pages/order_history_page/order_history_view_model.dart';

class CardHistoryWidget extends StatefulWidget {
  final Orders orders;
  const CardHistoryWidget({Key? key, required this.orders}) : super(key: key);

  @override
  State<CardHistoryWidget> createState() => _CardHistoryWidgetState();
}

class _CardHistoryWidgetState extends State<CardHistoryWidget> {
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    final rate = context.watch<OrdersHistoryViewModel>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                print('$url/${widget.orders.image!}'
                    .replaceAll("\n", '')
                    .toString()
                    .replaceAll(" ", ''));
              },
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(widget.orders.productId == 0
                        ? '$url/${widget.orders.packegeDetail![0].packageProfileImg!}'
                        : '$url/${widget.orders.productDetail![0].productProfileImg!}'
                            .replaceAll("\n", '')
                            .toString()
                            .replaceAll(" ", '')),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.orders.productId == 0
                          ? '${widget.orders.packegeDetail![0].name!}'
                          : '${widget.orders.productDetail![0].name!}',
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Price: ${widget.orders.productId == 0 ? '${widget.orders.packegeDetail![0].price!}' : '${widget.orders.productDetail![0].price!}'} JD ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Column(
            //   children: [
            //     TextButton(
            //         onPressed: () => showRating(),
            //         child: const Text(
            //           "Rate Product",
            //           style: TextStyle(
            //             fontSize: 15,
            //           ),
            //         )),
            //     ElevatedButton(
            //         onPressed: () {
            //           rate.rate(
            //               productId: widget.orders.productId!,
            //               businessId: widget.orders.businessId!,
            //               rating: rating.toInt());
            //         },
            //         child: Text("Send Data"))
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Widget buildRating() {
    final rate = context.watch<OrdersHistoryViewModel>();
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

  void showRating() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Rate This App"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Please Rate This Product"),
                  const SizedBox(
                    height: 32,
                  ),
                  buildRating(),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      // rate.rate(
                      //   productId: widget.orders.productId!,
                      //   businessId: widget.orders.businessId!,
                      //   rating: rating.toInt(),
                      // );

                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            ));
  }
}
