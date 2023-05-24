import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/cart_page/cart_view_model.dart';
import 'package:ward/view/widget/wishlist_widget/wishlist_product.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          translation(context).wishlist,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: wishlist.itemWishlist.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/wishlist_empty.jpg",
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return WishlistProduct(
                  id: wishlist.itemWishlist.values.toList()[index].id,
                  name:
                      wishlist.itemWishlist.values.toList()[index].productName,
                  productPrice:
                      wishlist.itemWishlist.values.toList()[index].productPrice,
                  image: wishlist.itemWishlist.values.toList()[index].image,
                  productID: wishlist.itemWishlist.keys.toList()[index],
                  itemId: wishlist.itemWishlist.values.toList()[index].id,
                );
              },
              itemCount: wishlist.itemWishlist.length,
            ),
      // FutureBuilder(
      //   future: wishlist.wishlistProducts,
      //   builder: (context, AsyncSnapshot<List<WishlistModel>> snapshot) {
      //     if (snapshot.hasData) {
      //       if (snapshot.data!.isEmpty) {
      //         return Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Image.asset(
      //               "assets/images/wishlist_empty.jpg",
      //             ),
      //           ],
      //         );
      //       }
      //       return ListView.builder(
      //         itemBuilder: (context, index) {
      //           return WishlistProduct(
      //             id: snapshot.data![index].id!,
      //             name: snapshot.data![index].name!,
      //             productPrice: snapshot.data![index].price!,
      //             image: snapshot.data![index].productProfileImg!,
      //             productID: snapshot.data![index].productId.toString(),
      //             itemId: snapshot.data![index].id!,
      //           );
      //         },
      //         itemCount: snapshot.data?.length,
      //       );
      //     } else if (snapshot.hasError) {
      //       print(snapshot.error.toString());
      //     }
      //     return Center(
      //         child: CircularProgressIndicator(
      //       color: mainColor,
      //     ));
      //   },
      // ),
      // body: Padding(
      //   padding: const EdgeInsets.all(10.0),
      //   child: FutureBuilder<List<Wishlist>>(
      //       future: wishlist.getData(),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState != ConnectionState.done) {
      //           return const Center(child: CircularProgressIndicator());
      //         } else if (snapshot.hasError) {
      //           print(snapshot.error);
      //         } else if (snapshot.data!.isEmpty) {
      //           return Center(
      //             child: Image.asset("assets/images/wishlist_empty.jpg"),
      //           );
      //         }
      //         return (snapshot.hasData)
      //             ? ListView.builder(
      //                 itemBuilder: (context, index) {
      //                   return WishlistProduct(
      //                     id: snapshot.data![index].id!,
      //                     name: snapshot.data![index].productName,
      //                     productPrice: snapshot.data![index].productPrice,
      //                     image: snapshot.data![index].image,
      //                     productID: snapshot.data![index].productId,
      //                   );
      //                 },
      //                 itemCount: snapshot.data?.length,
      //               )
      //             : Center(
      //                 child: Image.asset("assets/images/wishlist_empty.jpg"),
      //               );
      //       }),
    );
  }
}
