import 'package:flutter/material.dart';

import '../../../../utils/theme.dart';
import '../../text_utils.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({Key? key}) : super(key: key);

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  int radioContainerIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            buildRadioPayment(
                name: "PayPal",
                image: "assets/images/paypal.png",
                scale: 0.7,
                value: 1,
                onChange: (int? value) {
                  setState(() {
                    radioContainerIndex = value!;
                  });
                }),
            const SizedBox(
              height: 15,
            ),
            buildRadioPayment(
                name: "Google Pay",
                image: "assets/images/google.png",
                scale: 0.8,
                value: 2,
                onChange: (int? value) {
                  setState(() {
                    radioContainerIndex = value!;
                  });
                }),
            const SizedBox(
              height: 15,
            ),
            buildRadioPayment(
                name: "Credit",
                image: "assets/images/credit.png",
                scale: 0.7,
                value: 3,
                onChange: (int? value) {
                  setState(() {
                    radioContainerIndex = value!;
                  });
                }),
          ],
        ));
  }

  Widget buildRadioPayment({
    required String image,
    required String name,
    required double scale,
    required int value,
    required Function onChange,
  }) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                image,
                scale: scale,
              ),
              const SizedBox(
                width: 10,
              ),
              TextUtils(
                  fontWeight: FontWeight.bold,
                  text: name,
                  color: Colors.black,
                  fontSize: 25)
            ],
          ),
          Radio(
              value: value,
              fillColor: MaterialStateColor.resolveWith((states) => mainColor),
              groupValue: radioContainerIndex,
              onChanged: (int? value) {
                onChange(value);
              })
        ],
      ),
    );
  }
}
