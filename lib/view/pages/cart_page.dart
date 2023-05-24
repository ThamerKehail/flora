import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/view/pages/wishlist_page/wishlist_view_model.dart';

import '../widget/cart_widget/cart_widget.dart';
import 'cart_page/cart_view_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context);
    final wishlist = Provider.of<WishlistViewModel>(context);
    return Scaffold(
      body: SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CartWidget(
              itemId: wishlist.item.values.toList()[index].id,
              id: wishlist.item.values.toList()[index].id,
              name: wishlist.item.values.toList()[index].productName,
              description: '',
              productPrice:
                  wishlist.item.values.toList()[index].productPrice.toDouble(),
              initialPrice:
                  wishlist.item.values.toList()[index].productPrice.toDouble(),
              image: wishlist.item.values.toList()[index].image,
              qty: wishlist.item.values.toList()[index].quantity.toDouble(),
              productID: wishlist.item.keys.toList()[index],
              color: wishlist.item.values.toList()[index].color,
              businessId: wishlist.item.values.toList()[index].businessId,
              message: '',
            );
          },
          itemCount: wishlist.item.length,
        ),
      ),
    );
  }
}
