import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/models/cart_model.dart';
import 'package:ward/view/pages/cart_page/cart_view_model.dart';

import '../../../dio/cart_db/cart_db_helper.dart';
import '../../../utils/const.dart';
import '../../../utils/theme.dart';

class CartBouqWidget extends StatefulWidget {
  final String name;
  final String description;
  final String message;
  final double productPrice;
  final double initialPrice;
  final String itemId;

  final String image;
  final String id;
  final double qty;
  final int businessId;
  final String productID;
  final String color;

  const CartBouqWidget({
    Key? key,
    required this.itemId,
    required this.name,
    required this.description,
    required this.image,
    required this.id,
    required this.qty,
    required this.productID,
    required this.productPrice,
    required this.initialPrice,
    required this.color,
    required this.message,
    required this.businessId,
  }) : super(key: key);

  @override
  State<CartBouqWidget> createState() => _CartBouqWidgetState();
}

class _CartBouqWidgetState extends State<CartBouqWidget> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: CachedNetworkImage(
                width: 124,
                height: 124,
                imageUrl: '$url/${widget.image}',
                errorWidget: (BuildContext, String, dynamic) => Image.asset(
                  "assets/images/flora_cover.png",
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
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
                    "Price: ${widget.productPrice.toString()} JD ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      cart.removeBouquetItem(widget.productID);
                    },
                    icon: const Icon(Icons.delete)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.add,
                          color: mainColor,
                        ),
                        onTap: () {
                          cart.increaseBouquetItem(
                            productId: widget.productID,
                            image: widget.image,
                            productPrice: widget.productPrice,
                            productName: widget.name,
                          );
                        },
                      ),
                      Text(
                        widget.qty.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      InkWell(
                        child: Icon(
                          Icons.remove,
                          color: mainColor,
                        ),
                        onTap: () {
                          cart.removesBouquetSingleItem(widget.productID);
                          // double quantity = widget.qty.toDouble();
                          // double price = widget.initialPrice;
                          // quantity--;
                          // double? newPrice = price * quantity;
                          // if (quantity > 0) {
                          //   cart
                          //       .updateQty(
                          //     id: widget.itemId,
                          //     qty: quantity.toInt(),
                          //   )
                          //       .then((value) {
                          //     newPrice = 0;
                          //     quantity = 0;
                          //     cart.removeTotalPrice(
                          //         double.parse(widget.initialPrice.toString()));
                          //   }).onError((error, stackTrace) {
                          //     print(error.toString());
                          //   });
                          // }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
