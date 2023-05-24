import 'package:badges/badges.dart' as badge;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/global.dart';
import 'package:ward/utils/hex_color.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/product_details_page/product_details_view_model.dart';

import '../../../models/business_color_model.dart';
import '../../../models/product_model.dart';
import '../../../utils/language_constant.dart';
import '../../../utils/routes.dart';
import '../../widget/full_screen.dart';
import '../../widget/product_details/color_picker.dart';
import '../cart_page/cart_view_model.dart';

class ProductDetailsPage extends StatefulWidget {
  // final String name;
  //
  // final String productId;
  // final String nameAR;
  // final String image;
  // final String description;
  // final String descriptionAR;
  // final double price;
  // final int index;
  // final List<AllProductsBus> colors;
  // final String productProfileImg;
  // final int businessId;
  // final String email;
  final Product product;
  final String email;

  const ProductDetailsPage({
    Key? key,
    required this.product,
    required this.email,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
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
  @override
  void initState() {
    Future.microtask(() => context
        .read<ProductDetailsViewModel>()
        .getAllColors(businessId: widget.product.businessId));
    super.initState();
  }

  int val = 2;
  TextEditingController messageTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DetailScreen(
                            image: '$url/${widget.product.productProfileImg}',
                          )));
                },
                child: CachedNetworkImage(
                  width: 124,
                  height: 124,
                  imageUrl: "$url/${widget.product.productProfileImg}",
                  errorWidget: (BuildContext, String, dynamic) => Image.asset(
                    "assets/images/flora_cover.png",
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            floating: true,
            pinned: true,
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                    size: 25,
                  )),
            ),
            actions: [
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.cartScreen),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: badge.Badge(
                      badgeStyle: badge.BadgeStyle(
                        badgeColor: mainColor,
                      ),
                      badgeContent: Consumer<CartViewModel>(
                        builder: (context, value, child) {
                          return Text(
                            value.itemCount.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      badgeAnimation: badge.BadgeAnimation.slide(
                        disappearanceFadeAnimationDuration:
                            Duration(milliseconds: 300),
                        // curve: Curves.easeInCubic,
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final productDetails = context.watch<ProductDetailsViewModel>();
    final cart = Provider.of<CartViewModel>(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translation(context).localeName == 'en'
                  ? widget.product.name
                  : widget.product.nameEr,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              translation(context).localeName == 'en'
                  ? widget.product.description
                  : widget.product.descriptionEr,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.product.price} JD",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Choose the color of your bouquet",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            FutureBuilder<List<BusinessColors>>(
                future: productDetails.colors,
                builder: (context, snapshot) {
                  if (snapshot.hasError ||
                      snapshot.connectionState != ConnectionState.done) {
                    print(snapshot.toString());
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Image.asset("assets/images/nproduct.png"),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColorPicker(
                                index: index,
                                color: HexColor.fromHex(
                                    '${snapshot.data![index].colorID}'),
                                outBorder: currentColor == index,
                                currentColor: snapshot.data![index].colorID,
                              ),
                            ],
                          );
                        },
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 3,
                            )),
                  );
                }),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Do you want to write your message?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Column(
              children: [
                TextFormField(
                  controller: messageTextController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: translation(context).enterMessage,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .15,
            ),
            Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 12,
              child: cart.item.isEmpty
                  ? InkWell(
                      onTap: () {
                        userId == 0
                            ? showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title:
                                      const Text('You cannot add the product'),
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
                            : snackBar("Product add To cart ");
                        print(bouColor == Colors.red ? 1 : 0);

                        userId == 0
                            ? null
                            : cart.addItem(
                                businessEmail: widget.email,
                                productId: widget.product.productId.toString(),
                                image: widget.product.productProfileImg,
                                productPrice: widget.product.price,
                                productName: widget.product.name,
                                color: '${productDetails.colorBouq}'
                                    .replaceFirst('#', ''),
                                businessId: widget.product.businessId,
                                message: messageTextController.text,
                              );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          height: 65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                translation(context).addToCart,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 35,
                              )
                            ],
                          )),
                    )
                  : cart.item.values.toList().indexWhere((element) =>
                              element.businessId ==
                              widget.product.businessId) ==
                          -1
                      ? InkWell(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
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
                                    cart.clear();
                                  },
                                  child: const Text('Clear Cart'),
                                ),
                              ],
                            ),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              height: 65,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Can't Add",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  )
                                ],
                              )),
                        )
                      : InkWell(
                          onTap: () {
                            snackBar("Product add To cart ");
                            cart.addItem(
                              productId: widget.product.productId.toString(),
                              image: widget.product.productProfileImg,
                              productPrice: widget.product.price,
                              productName: widget.product.name,
                              color: productDetails.colorBouq,
                              businessId: widget.product.businessId,
                              message: messageTextController.text,
                              businessEmail: widget.email,
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              height: 65,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    translation(context).addToCart,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  )
                                ],
                              )),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
