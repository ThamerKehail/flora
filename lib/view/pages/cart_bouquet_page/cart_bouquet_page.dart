import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/cart_page/cart_view_model.dart';

import '../../../utils/global.dart';
import '../../widget/cart_widget/cart_bouq_widget.dart';
import '../../widget/cart_widget/payment/delivery_container_widget.dart';
import '../../widget/cart_widget/reusable_widget.dart';
import '../../widget/checkout_widget/text_field.dart';
import '../../widget/text_utils.dart';
import '../Success_page/successs_page.dart';

class CartBouquetPage extends StatefulWidget {
  final String currentColor;
  final String message;
  const CartBouquetPage(
      {Key? key, required this.currentColor, required this.message})
      : super(key: key);

  @override
  State<CartBouquetPage> createState() => _CartBouquetPageState();
}

class _CartBouquetPageState extends State<CartBouquetPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<CartViewModel>().getAllCartProducts());
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
      ),
      body: cart.bouquetList.isEmpty
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
                                  : cart.bouquetList.isEmpty
                                      ? SizedBox()
                                      : cart.currentStep_ != 1
                                          ? ElevatedButton(
                                              onPressed: details.onStepContinue,
                                              child: Text(
                                                  translation(context).next),
                                            )
                                          : ElevatedButton(
                                              onPressed: cart.currentStep_ == 1
                                                  ? () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        details
                                                            .onStepContinue!();
                                                      }
                                                    }
                                                  : details.onStepContinue,
                                              child: Text(
                                                  translation(context).next),
                                            ),
                              const SizedBox(
                                width: 12,
                              ),
                              if (cart.currentStep_ != 0)
                                ElevatedButton(
                                  onPressed: details.onStepCancel,
                                  child: Text(translation(context).back),
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
                              SizedBox(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return CartBouqWidget(
                                      itemId: cart.bouquetList.values
                                          .toList()[index]
                                          .id,
                                      id: cart.bouquetList.values
                                          .toList()[index]
                                          .id,
                                      name: cart.bouquetList.values
                                          .toList()[index]
                                          .productName,
                                      description: '',
                                      productPrice: cart.bouquetList.values
                                          .toList()[index]
                                          .productPrice
                                          .toDouble(),
                                      initialPrice: cart.bouquetList.values
                                          .toList()[index]
                                          .productPrice
                                          .toDouble(),
                                      image: cart.bouquetList.values
                                          .toList()[index]
                                          .image,
                                      qty: cart.bouquetList.values
                                          .toList()[index]
                                          .quantity
                                          .toDouble(),
                                      productID:
                                          cart.bouquetList.keys.toList()[index],
                                      color: widget.currentColor,
                                      businessId: cart.bouquetList.values
                                          .toList()[index]
                                          .businessId,
                                      message: widget.message,
                                    );
                                  },
                                  itemCount: cart.bouquetList.length,
                                ),
                              ),
                              Consumer<CartViewModel>(
                                  builder: (context, value, child) {
                                return Visibility(
                                  visible: value.totalBouquetAmount
                                              .toStringAsFixed(2) ==
                                          "0.00"
                                      ? false
                                      : true,
                                  child: Column(
                                    children: [
                                      ReusableWidget(
                                          title: translation(context).subtotal,
                                          value:
                                              "${value.totalBouquetAmount.toStringAsFixed(2)} JD"),
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
                                          cart.clearBouquet();
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
                                    hint: translation(context).writeNote,
                                    label: translation(context).addNote,
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
                                  TextUtils(
                                    fontWeight: FontWeight.bold,
                                    text: translation(context).shopping,
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
                                          "${translation(context).total}:${cart.totalBouquetAmount.toStringAsFixed(2)} JD",
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      height: 50,
                                      width: 150,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              elevation: 0,
                                              primary: mainColor),
                                          onPressed: () async {
                                            // cart.dbHelper.deleteAll();

                                            cart.currentStep = 0;
                                            cart.activeStep = 0;
                                            cart.currentStep_ = 0;
                                            // cart.address(
                                            //   city: cart.city.text,
                                            //   address: cart.addressText.text,
                                            //   streetName: cart.street.text,
                                            //   building: int.parse(
                                            //       cart.building.text),
                                            //   floor:
                                            //       int.parse(cart.floor.text),
                                            //   mobile: cart.phone.text,
                                            //   userId: userId,
                                            //   businessId: cart
                                            //       .bouquetList.values
                                            //       .toList()[0]
                                            //       .businessId,
                                            //   status: 0,
                                            //   note: cart.note.text,
                                            // );
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            cart.bouquetList.values
                                                .toList()
                                                .forEach((element) async {
                                              cart.cartBouqet.add({
                                                'order_id':
                                                    '${prefs.getInt('order_id')}',
                                                'business_id':
                                                    element.businessId,
                                                'userID': userId,
                                                'payment_method': 2,
                                                'product_id': '0',
                                                'Qty': element.quantity,
                                                'single_price':
                                                    element.productPrice,
                                                'total_price':
                                                    (element.productPrice *
                                                        element.quantity),
                                                'color': '${element.color}',
                                                'image': element.image,
                                                'name': element.productName,
                                                'message': element.message,
                                                'type': '1',
                                                'package_id': element.packageID,
                                              });
                                              print(
                                                  "==================cart===============");
                                              print(cart.cartBouqet.length);
                                              print(cart.cartBouqet);
                                              cart.ordersDetails(
                                                dataList: cart.cartBouqet,
                                                context: context,
                                              );
                                              // cart.ordersDetails(
                                              //   dataList: cart.cartBouqet,
                                              //   context: context,
                                              // );
                                              // cart.sendEmail(
                                              //     toEmail: cart
                                              //         .bouquetList
                                              //         .values
                                              //         .first
                                              //         .businessEmail,
                                              //     name: 'Flora App',
                                              //     email:
                                              //         "wardapplication2@gmail.com",
                                              //     subject: "New Order",
                                              //     message: 'message');
                                              // await cart.ordersDetails(
                                              //   businessId: element.businessId,
                                              //   paymentMethod: 1,
                                              //   productId:
                                              //       int.parse(element.id),
                                              //   qty:
                                              //       element.quantity.toDouble(),
                                              //   singlePrice: element
                                              //       .productPrice
                                              //       .toDouble(),
                                              //   totalPrice: (element.quantity *
                                              //           element.productPrice)
                                              //       .toDouble(),
                                              //   color: widget.currentColor,
                                              //   message: widget.message,
                                              //   type: 1,
                                              //   name: element.productName,
                                              //   image: element.image,
                                              //   context: context,
                                              // );
                                              // .whenComplete(() =>
                                              //     cart.clearBouquet());
                                            });
                                            cart.sendEmail(
                                              name: 'Flora App',
                                              email:
                                                  'wardapplication2@gmail.com',
                                              toEmail: cart.bouquetList.values
                                                  .first.businessEmail,
                                              subject: "New Order",
                                              message: "message",
                                            );
                                            cart.phone.clear();
                                            cart.note.clear();
                                            cart.city.clear();
                                            cart.addressText.clear();
                                            cart.street.clear();
                                            cart.building.clear();
                                            cart.floor.clear();

                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            SuccessPage()));

                                            // Navigator.of(context).pushNamed(
                                            //     AppRoutes.mainHomeScreen);
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
