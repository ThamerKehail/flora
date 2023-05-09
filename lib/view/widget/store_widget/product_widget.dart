import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/product_model.dart';
import 'package:ward/utils/const.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/product_details_page/product_details_page.dart';

import '../../pages/cart_page/cart_view_model.dart';
import '../full_screen.dart';

class ProductWidget extends StatefulWidget {
  Product product;
  int index;
  String businessEmail;

  ProductWidget({
    Key? key,
    required this.product,
    required this.index,
    required this.businessEmail,
  }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  // ProfileViewModel _profileViewModel = ProfileViewModel();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                    product: widget.product,
                    email: widget.businessEmail,
                  )),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Flexible(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height * .23,
                        child: Text(
                          translation(context).localeName == 'en'
                              ? widget.product.name
                              : widget.product.nameEr,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${widget.product.price} JD ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      cart.item.isEmpty
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
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pushNamed(context,
                                                      AppRoutes.loginScreen),
                                              child: const Text('Login'),
                                            ),
                                          ],
                                        ),
                                      )
                                    : snackBar("Product add To cart ");
                                userId == 0
                                    ? null
                                    : cart.addItem(
                                        productId:
                                            widget.product.productId.toString(),
                                        image: widget.product.productProfileImg,
                                        productPrice: widget.product.price,
                                        productName: widget.product.name,
                                        color: '0',
                                        businessId: widget.product.businessId,
                                        message: "message not found",
                                        businessEmail: widget.businessEmail,
                                      );
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                color: mainColor,
                                size: 30,
                              ))
                          : cart.item.values.toList().indexWhere((element) =>
                                      element.businessId ==
                                      widget.product.businessId) ==
                                  -1
                              ? IconButton(
                                  onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title:
                                              const Text('Can\'t Add Product'),
                                          content: const Text(
                                              'Cart include product from other business'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, 'OK');
                                                cart.clear();
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
                                    snackBar("Product add To cart ");
                                    print("add");
                                    cart.addItem(
                                      productId:
                                          widget.product.productId.toString(),
                                      image: widget.product.productProfileImg,
                                      productPrice: widget.product.price,
                                      productName: widget.product.name,
                                      color: '0',
                                      businessId: widget.product.businessId,
                                      message: "Message not found",
                                      businessEmail: widget.businessEmail,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: mainColor,
                                    size: 30,
                                  )),
                      cart.itemWishlist
                              .containsKey(widget.product.productId.toString())
                          ? IconButton(
                              onPressed: () {
                                cart.removeWishItem(
                                    widget.product.productId.toString());
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: mainColor,
                              ))
                          : IconButton(
                              onPressed: () {
                                snackBar("Product add To wishlist ");
                                cart.addWishItem(
                                  productId:
                                      widget.product.productId.toString(),
                                  image: widget.product.productProfileImg,
                                  productPrice: widget.product.price,
                                  productName: widget.product.name,
                                  color: '0',
                                  businessId: widget.product.businessId,
                                  message: "Message not found",
                                  businessEmail: widget.businessEmail,
                                );
                              },
                              icon: Icon(
                                Icons.favorite_outline,
                                color: mainColor,
                              )),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DetailScreen(
                            image: '$url/${widget.product.productProfileImg}',
                          )));
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                          "$url/${widget.product.productProfileImg}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // checkData(BuildContext context) {
  //   final cart = Provider.of<CartViewModel>(context);
  //   FutureBuilder(
  //     future: cart.getData(),
  //     builder: (context, AsyncSnapshot<List<CartProduct>> snapshot) {
  //       return Text(
  //         snapshot.data.toString(),
  //         style: TextStyle(
  //           color: Colors.black,
  //         ),
  //       );
  //     },
  //   );
  // }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
