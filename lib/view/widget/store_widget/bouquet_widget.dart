import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/package_model.dart';
import 'package:ward/utils/global.dart';
import 'package:ward/view/pages/bouquet_details/bouquet_view_main.dart';

import '../../../utils/routes.dart';
import '../../../utils/theme.dart';
import '../../pages/cart_page/cart_view_model.dart';
import '../../pages/product_details_page/product_details_view_model.dart';

class BouquetWidget extends StatefulWidget {
  final Package package;
  final String email;
  int index;
  List colors;
  BouquetWidget(
      {Key? key,
      required this.package,
      required this.index,
      required this.colors,
      required this.email})
      : super(key: key);

  @override
  State<BouquetWidget> createState() => _BouquetWidgetState();
}

class _BouquetWidgetState extends State<BouquetWidget> {
  @override
  Widget build(BuildContext context) {
    final bouquet = Provider.of<BouquetViewModel>(context);
    final cart = Provider.of<CartViewModel>(context);
    final productDetails = context.watch<ProductDetailsViewModel>();

    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.package.name,
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
                    "${widget.package.price} JD ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  //bou
                  cart.bouquetList.isEmpty
                      ? IconButton(
                          onPressed: () {
                            userId == 0
                                ? showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text(
                                          'You cannot add the product'),
                                      content: const Text(
                                          'To add a product, you must log in'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pushNamed(
                                              context, AppRoutes.loginScreen),
                                          child: const Text('Login'),
                                        ),
                                      ],
                                    ),
                                  )
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Product add To Bouquet'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );

                            userId == 0
                                ? null
                                : cart.addBouquetItem(
                                    productId:
                                        widget.package.packageId.toString(),
                                    image: widget.package.packageProfileImg,
                                    productPrice: widget.package.price,
                                    productName: widget.package.name,
                                    businessId: widget.package.businessId,
                                    message: "",
                                    businessEmail: widget.email,
                                    color: '${productDetails.colorBouq}');
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            color: mainColor,
                            size: 30,
                          ))
                      : cart.bouquetList.values.toList().indexWhere((element) =>
                                  element.businessId ==
                                  widget.package.businessId) ==
                              -1
                          ? IconButton(
                              onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Can\'t Add Product'),
                                      content: const Text(
                                          'Cart include product from other business'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'OK');
                                            cart.clearBouquet();
                                          },
                                          child: const Text('Clear Cart'),
                                        ),
                                      ],
                                    ),
                                  ),
                              icon: Icon(
                                Icons.shopping_cart,
                                color: mainColor,
                                size: 30,
                              ))
                          : IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Product add To Bouquet'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );

                                cart.addBouquetItem(
                                    productId:
                                        widget.package.packageId.toString(),
                                    image: widget.package.packageProfileImg,
                                    productPrice: widget.package.price,
                                    productName: widget.package.name,
                                    businessId: widget.package.businessId,
                                    message: '',
                                    businessEmail: widget.email,
                                    color: '${productDetails.colorBouq}');
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                color: mainColor,
                                size: 30,
                              )),
                  // FutureBuilder(
                  //     future: bouquet
                  //         .checkIfExist(widget.package.packageId.toString()),
                  //     builder: (context, snap) {
                  //       return snap.data == true
                  //           ? InkWell(
                  //               onTap: () {
                  //                 dbHelper.delete(widget.package.packageId);
                  //                 bouquet.removeCounter();
                  //                 bouquet.removeTotalPrice(double.parse(
                  //                     widget.package.price.toString()));
                  //               },
                  //               child: Container(
                  //                   width: 100,
                  //                   height: 30,
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     color: Colors.white,
                  //                     boxShadow: const [
                  //                       BoxShadow(
                  //                         color: Colors.grey,
                  //                         spreadRadius: 1,
                  //                         blurRadius: 3,
                  //                         offset: Offset(0, 3),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   child: Center(
                  //                     child: Text(
                  //                       "Added",
                  //                       style: TextStyle(
                  //                         color: mainColor,
                  //                         fontSize: 20,
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   )),
                  //             )
                  //           : InkWell(
                  //               onTap: () {
                  //                 bouquetDBHelper
                  //                     .insert(Bouquet(
                  //                   productId:
                  //                       widget.package.packageId.toString(),
                  //                   image: widget.package.packageProfileImg,
                  //                   id: widget.package.packageId,
                  //                   initialPrice: widget.package.price,
                  //                   productName: widget.package.name,
                  //                   productPrice: widget.package.price,
                  //                   quantity: 1,
                  //                 ))
                  //                     .then((value) {
                  //                   print("Product is added to cart");
                  //                   bouquet.addTotalPrice(
                  //                     double.parse(
                  //                         widget.package.price.toString()),
                  //                   );
                  //                   bouquet.addCounter();
                  //                 }).onError((error, stackTrace) {
                  //                   print(error.toString());
                  //                 });
                  //               },
                  //               child: Container(
                  //                   width: 100,
                  //                   height: 30,
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     color: Colors.white,
                  //                     boxShadow: const [
                  //                       BoxShadow(
                  //                         color: Colors.grey,
                  //                         spreadRadius: 1,
                  //                         blurRadius: 3,
                  //                         offset: Offset(0, 3),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   child: Center(
                  //                     child: Text(
                  //                       translation(context).addFlower,
                  //                       style: TextStyle(
                  //                         color: mainColor,
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   )),
                  //             );
                  //     }),
                ],
              ),
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                          '$url/${widget.package.packageProfileImg}'),
                      fit: BoxFit.cover,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
