import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/global.dart';

import '../../../utils/theme.dart';
import '../../pages/cart_page/cart_view_model.dart';
import '../full_screen.dart';

class BouquetWidget extends StatefulWidget {
  final String image;
  final String name;

  final int qty;
  final double price;
  final String packageId;
  final String id;
  final double initPrice;
  const BouquetWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.qty,
    required this.price,
    required this.packageId,
    required this.id,
    required this.initPrice,
  }) : super(key: key);

  @override
  State<BouquetWidget> createState() => _BouquetWidgetState();
}

class _BouquetWidgetState extends State<BouquetWidget> {
  @override
  Widget build(BuildContext context) {
    final bouquet = Provider.of<CartViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DetailScreen(
                        image: widget.image,
                      );
                    }));
                  },
                  child: CachedNetworkImage(
                    width: 124,
                    height: 124,
                    imageUrl: "$url/${widget.image}",
                    errorWidget: (BuildContext, String, dynamic) => Image.asset(
                      "assets/images/flora_cover.png",
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.name,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                '${widget.price.toString()} JD',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              Row(
                children: [
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
                            bouquet.increaseBouquetItem(
                              productId: widget.packageId,
                              image: widget.image,
                              productPrice: widget.price,
                              productName: widget.name,
                            );
                            // int quantity = widget.qty;
                            // double price = widget.initPrice;
                            // quantity++;
                            // double? newPrice = price * quantity;
                            // dbHelper
                            //     .updateQuantity(Bouquet(
                            //   productId: widget.packageId,
                            //   image: widget.image,
                            //   id: widget.id,
                            //   productPrice: newPrice,
                            //   productName: widget.name,
                            //   initialPrice: widget.initPrice,
                            //   quantity: quantity,
                            // ))
                            //     .then((value) {
                            //   newPrice = 0;
                            //   quantity = 0;
                            //   bouquet.addTotalPrice(
                            //       double.parse(widget.initPrice.toString()));
                            // }).onError((error, stackTrace) {
                            //   debugPrint(error.toString());
                            // });
                          },
                        ),
                        Text(
                          widget.qty.toString(),
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
                            bouquet.removesBouquetSingleItem(widget.packageId);
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        bouquet.removeBouquetItem(widget.packageId);
                      },
                      icon: const Icon(Icons.delete)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
