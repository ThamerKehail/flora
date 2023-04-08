import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/cart_page/cart_view_model.dart';
import 'package:ward/view/widget/cart_widget/cart_widget.dart';
import '../../../utils/const.dart';
import '../../widget/cart_widget/payment/delivery_container_widget.dart';
import '../../widget/cart_widget/reusable_widget.dart';
import '../../widget/checkout_widget/text_field.dart';
import '../../widget/text_utils.dart';
import '../Success_page/successs_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();

  PaymentSdkConfigurationDetails generateConfig(double total) {
    var billingDetails = BillingDetails("John Smith", "email@domain.com",
        "+97311111111", "st. 12", "jo", "dubai", "dubai", "12345");
    var shippingDetails = ShippingDetails("John Smith", "email@domain.com",
        "+97311111111", "st. 12", "jo", "dubai", "dubai", "12345");
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.AMAN);
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "101364",
        serverKey: "SZJNGM9BDR-JGJ96J6ZGT-M9JRG99LTL",
        clientKey: "CTKMN2-MTQN6T-6PG6G9-BQB6QN",
        cartId: "12433",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        screentTitle: "Pay with Card",
        amount: total,
        showBillingInfo: true,
        forceShippingInfo: false,
        currencyCode: "JOD",
        merchantCountryCode: "JO",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        alternativePaymentMethods: apms,
        linkBillingNameWithCardHolderName: true);

    var theme = IOSThemeConfigurations();

    theme.logoImage = "assets/images/flora_logo.png";

    configuration.iOSThemeConfigurations = theme;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

  Future<void> payPressed(double total) async {
    FlutterPaytabsBridge.startCardPayment(generateConfig(total), (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<CartViewModel>().getAllCartProducts());
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final cart = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
      ),
      body: cart.item.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/Empty-Cart.jpg",
                ),
              ],
            )
          : Column(
              children: [
                Theme(
                  data: ThemeData(
                    canvasColor: Colors.white,
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: mainColor,
                          background: Colors.red,
                          secondary: mainColor,
                        ),
                  ),
                  child: Expanded(
                    child: Stepper(
                      elevation: 0.0,
                      type: StepperType.horizontal,
                      physics: const ScrollPhysics(),
                      currentStep: cart.currentStep_,
                      onStepTapped: (step) => tapped(step),
                      onStepContinue: () {
                        setState(() => cart.currentStep_ += 1);
                      },
                      onStepCancel: () {
                        setState(() => cart.currentStep_ -= 1);
                      },
                      controlsBuilder: (context, ControlsDetails details) {
                        final isLastStep = cart.currentStep_ == 2;
                        return Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: Row(
                            children: [
                              isLastStep
                                  ? const SizedBox()
                                  : cart.item.isEmpty
                                      ? SizedBox()
                                      : cart.currentStep_ != 1
                                          ? ElevatedButton(
                                              onPressed: details.onStepContinue,
                                              child: const Text("NEXT"),
                                            )
                                          : ElevatedButton(
                                              onPressed: cart.currentStep_ == 1
                                                  ? () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        cart
                                                            .address(
                                                              city: cart
                                                                  .city.text,
                                                              address: cart
                                                                  .addressText
                                                                  .text,
                                                              streetName: cart
                                                                  .street.text,
                                                              building:
                                                                  int.parse(cart
                                                                      .building
                                                                      .text),
                                                              floor: int.parse(
                                                                  cart.floor
                                                                      .text),
                                                              mobile: cart.phone
                                                                      .text ??
                                                                  "0785020222",
                                                              note: cart
                                                                  .note.text,
                                                              userId: userId,
                                                              status: 0,
                                                              businessId: cart
                                                                  .item.values
                                                                  .toList()[0]
                                                                  .businessId,
                                                            )
                                                            .whenComplete(() =>
                                                                details
                                                                    .onStepContinue!());
                                                      }
                                                    }
                                                  : details.onStepContinue,
                                              child: const Text("NEXT"),
                                            ),
                              const SizedBox(
                                width: 12,
                              ),
                              if (cart.currentStep_ != 0)
                                ElevatedButton(
                                  onPressed: details.onStepCancel,
                                  child: const Text("BACK"),
                                ),
                            ],
                          ),
                        );
                      },
                      steps: <Step>[
                        Step(
                          title: Text(translation(context).cart),
                          content: Column(
                            children: [
                              // FutureBuilder<List<CartProductModel>>(
                              //     future: cart.cartProducts,
                              //     builder: (context,
                              //         AsyncSnapshot<List<CartProductModel>>
                              //             snapshot) {
                              //       if (snapshot.hasData) {
                              //         if (snapshot.data!.isEmpty) {
                              //           cart.isEmpty = true;
                              //           return Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //             mainAxisAlignment: MainAxisAlignment.center,
                              //             children: [
                              //               Image.asset(
                              //                 "assets/images/Empty-Cart.jpg",
                              //               ),
                              //             ],
                              //           );
                              //         }
                              //         cart.isEmpty = false;
                              //         return Column(
                              //           crossAxisAlignment: CrossAxisAlignment.end,
                              //           children: [
                              //             SizedBox(
                              //               height:
                              //                   MediaQuery.of(context).size.height *
                              //                       snapshot.data!.length /
                              //                       6,
                              //               child: ListView.builder(
                              //                 itemBuilder: (context, index) {
                              //                   cart.businessId =
                              //                       snapshot.data![index].businessId;
                              //                   return CartWidget(
                              //                     itemId: snapshot.data![index].id!,
                              //                     id: snapshot.data![index].id!,
                              //                     name: cart
                              //                         .allCartProducts[index].name
                              //                         .toString(),
                              //                     description: "",
                              //                     productPrice: snapshot
                              //                         .data![index].price!
                              //                         .toDouble(),
                              //                     initialPrice: snapshot
                              //                         .data![index].price!
                              //                         .toDouble(),
                              //                     image: snapshot.data![index]
                              //                         .productProfileImg!,
                              //                     qty: snapshot.data![index].qty!,
                              //                     productID: snapshot
                              //                         .data![index].productId
                              //                         .toString(),
                              //                     color: 0,
                              //                     businessId: snapshot
                              //                         .data![index].businessId!,
                              //                     message: '',
                              //                   );
                              //                 },
                              //                 itemCount: snapshot.data!.length,
                              //               ),
                              //             ),
                              //           ],
                              //         );
                              //       } else if (snapshot.hasError) {
                              //         print(snapshot.error);
                              //       }
                              //       return const CircularProgressIndicator();
                              //     }),
                              SizedBox(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return CartWidget(
                                      itemId:
                                          cart.item.values.toList()[index].id,
                                      id: cart.item.values.toList()[index].id,
                                      name: cart.item.values
                                          .toList()[index]
                                          .productName,
                                      description: '',
                                      productPrice: cart.item.values
                                          .toList()[index]
                                          .productPrice
                                          .toDouble(),
                                      initialPrice: cart.item.values
                                          .toList()[index]
                                          .productPrice
                                          .toDouble(),
                                      image: cart.item.values
                                          .toList()[index]
                                          .image,
                                      qty: cart.item.values
                                          .toList()[index]
                                          .quantity
                                          .toDouble(),
                                      productID: cart.item.keys.toList()[index],
                                      color: cart.item.values
                                          .toList()[index]
                                          .color,
                                      businessId: cart.item.values
                                          .toList()[index]
                                          .businessId,
                                      message: '',
                                    );
                                  },
                                  itemCount: cart.item.length,
                                ),
                              ),
                              Consumer<CartViewModel>(
                                  builder: (context, value, child) {
                                return Visibility(
                                  visible:
                                      value.totalAmount.toStringAsFixed(2) ==
                                              "0.00"
                                          ? false
                                          : true,
                                  child: Column(
                                    children: [
                                      ReusableWidget(
                                          title: translation(context).subtotal,
                                          value:
                                              "${value.totalAmount.toStringAsFixed(2)} JD"),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: mainColor,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 25,
                                          child: const Center(
                                            child: Text(
                                              "Delete All Item",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          // cart.dbHelper.deleteAll();
                                          // cart.removeAllCounter();
                                          // cart.removeAllTotalPrice();
                                          cart.clear();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              })
                            ],
                          ),
                          isActive: cart.currentStep_ >= 0,
                          state: cart.currentStep_ >= 0
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: Text(translation(context).address),
                          content: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldWidget(
                                    hint: translation(context).enterCity,
                                    label: translation(context).city,
                                    textEditingController: cart.city,
                                    textType: TextInputType.text,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please Enter Your City";
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextFieldWidget(
                                    hint: translation(context).enterAddress,
                                    label: translation(context).address,
                                    textEditingController: cart.addressText,
                                    textType: TextInputType.text,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please Enter Your Address";
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextFieldWidget(
                                    hint: translation(context).enterStreet,
                                    label: translation(context).street,
                                    textEditingController: cart.street,
                                    textType: TextInputType.text,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please Enter Your Street";
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextFieldWidget(
                                    hint: translation(context).enterBuilding,
                                    label: translation(context).building,
                                    textEditingController: cart.building,
                                    textType: TextInputType.phone,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please Enter Your Building Number";
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextFieldWidget(
                                    hint: translation(context).enterFloor,
                                    label: translation(context).floor,
                                    textEditingController: cart.floor,
                                    textType: TextInputType.phone,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please Enter Your Floor Number";
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextFieldWidget(
                                    hint: translation(context).enterPhone,
                                    label: translation(context).phoneNumber,
                                    textEditingController: cart.phone,
                                    textType: TextInputType.phone,
                                    validator: (value) {
                                      RegExp regex =
                                          RegExp(r'(^(?:[+0]9)?[0-9]{10,10}$)');
                                      if (!regex.hasMatch(value)) {
                                        return 'Enter Valid Phone Number';
                                      } else
                                        return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextFieldWidget(
                                    hint: "Please write note",
                                    label: "Add Note",
                                    textEditingController: cart.note,
                                    textType: TextInputType.text,
                                    validator: (value) {
                                      if (value.toString().isEmpty)
                                        return "Please Enter any note";
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          isActive: cart.currentStep_ >= 1,
                          state: cart.currentStep_ >= 1
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: Text(translation(context).payment),
                          content: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextUtils(
                                    fontWeight: FontWeight.bold,
                                    text: "Shopping to",
                                    color: Colors.black,
                                    fontSize: 24,
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DeliveryContainerWidget(
                                    address: cart.addressText.text,
                                    phone: cart.phone.text,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: TextUtils(
                                      fontWeight: FontWeight.bold,
                                      text:
                                          "Total:${cart.totalAmount.toStringAsFixed(2)} JD",
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: cart.pageLoading == true
                                        ? CircularProgressIndicator()
                                        : SizedBox(
                                            height: 50,
                                            width: 150,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    backgroundColor: mainColor,
                                                    elevation: 0),
                                                onPressed: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  cart.item
                                                      .forEach((key, element) {
                                                    cart.setLoading(true);
                                                    cart.cartProduct.add({
                                                      'order_id':
                                                          '${prefs.getInt('order_id')}',
                                                      'business_id':
                                                          element.businessId,
                                                      'userID': userId,
                                                      'payment_method': 2,
                                                      'product_id':
                                                          element.productID,
                                                      'Qty': element.quantity,
                                                      'single_price':
                                                          element.productPrice,
                                                      'total_price': (element
                                                              .productPrice *
                                                          element.quantity),
                                                      'color':
                                                          '${element.color}',
                                                      'image': element.image,
                                                      'name':
                                                          element.productName,
                                                      'message':
                                                          element.message,
                                                      'type': '1',
                                                    });
                                                  });
                                                  print(
                                                      "==================cart===============");
                                                  print(
                                                      cart.cartProduct.length);
                                                  print(cart.cartProduct);

                                                  cart.ordersDetails(
                                                    businessId: 1,
                                                    paymentMethod: 1,
                                                    productId: 1,
                                                    qty: 1,
                                                    singlePrice: 1,
                                                    totalPrice: 1,
                                                    color: '1',
                                                    message: 'message',
                                                    type: 1,
                                                    name: 'name',
                                                    image: 'image',
                                                    dataList: cart.cartProduct,
                                                    context: context,
                                                  );
                                                  cart.setLoading(false);
                                                },
                                                child: Text(
                                                  translation(context).pay,
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      color: Colors.white),
                                                )),
                                          ),
                                  )
                                  // totalWidget(),
                                ],
                              ),
                            ),
                          ),
                          isActive: cart.currentStep_ >= 2,
                          state: cart.currentStep_ >= 2
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  tapped(int step) {
    final cart = Provider.of<CartViewModel>(context);

    setState(() => cart.currentStep_ = step);
  }

  continued() {
    final cart = Provider.of<CartViewModel>(context);

    cart.currentStep_ < 2 ? setState(() => cart.currentStep_ += 1) : null;
  }

  cancel() {
    final cart = Provider.of<CartViewModel>(context);

    cart.currentStep_ > 0 ? setState(() => cart.currentStep_ -= 1) : null;
  }
}
