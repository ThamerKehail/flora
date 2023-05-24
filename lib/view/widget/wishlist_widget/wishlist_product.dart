import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/dio/wishlist_db/wishlist_db_helper.dart';
import 'package:ward/view/pages/wishlist_page/wishlist_view_model.dart';

import '../../../utils/global.dart';
import '../../pages/cart_page/cart_view_model.dart';

class WishlistProduct extends StatefulWidget {
  final String name;

  final double productPrice;

  final String image;
  final String id;
  final String itemId;

  final String productID;
  const WishlistProduct({
    Key? key,
    required this.name,
    required this.image,
    required this.id,
    required this.productID,
    required this.productPrice,
    required this.itemId,
  }) : super(key: key);

  @override
  State<WishlistProduct> createState() => _WishlistProductState();
}

class _WishlistProductState extends State<WishlistProduct> {
  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<CartViewModel>(context);
    return InkWell(
      onTap: () {},
      child: Card(
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
                  image: DecorationImage(
                    image: NetworkImage('$url/${widget.image}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        wishlist.removeWishItem(widget.productID);
                      },
                      icon: const Icon(Icons.delete)),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
