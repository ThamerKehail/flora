import 'package:flutter/material.dart';
import 'package:ward/utils/language_constant.dart';

import '../../text_utils.dart';

class DeliveryContainerWidget extends StatefulWidget {
  final String address;
  final String phone;
  const DeliveryContainerWidget(
      {Key? key, required this.address, required this.phone})
      : super(key: key);

  @override
  State<DeliveryContainerWidget> createState() =>
      _DeliveryContainerWidgetState();
}

class _DeliveryContainerWidgetState extends State<DeliveryContainerWidget> {
  int radioContainerIndex = 1;
  bool changeColor = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildRadioContainer(
            address: widget.address,
            name: "Flora App",
            phone: widget.phone,
            value: 1,
            title: translation(context).cash,
            color: changeColor ? Colors.white : Colors.grey.shade300,
            onChanged: (int? value) {
              setState(() {
                radioContainerIndex = value!;
                changeColor = !changeColor;
              });
            }),
        const SizedBox(
          height: 10,
        ),
        // buildRadioContainer(
        //     address: "Amman Jordan",
        //     name: "Thamer Emad",
        //     phone: "0786007824",
        //     value: 2,
        //     title: "Delivery ",
        //     color: changeColor ? Colors.grey.shade300 : Colors.white,
        //     onChanged: (int? value) {
        //       setState(() {
        //         radioContainerIndex = value!;
        //         changeColor = !changeColor;
        //       });
        //     }),
      ],
    );
  }

  Widget buildRadioContainer({
    required Color color,
    required int value,
    required Function onChanged,
    required String title,
    required String phone,
    required String name,
    required String address,
  }) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Radio(
              value: value,
              groupValue: radioContainerIndex,
              onChanged: (int? value) {
                onChanged(value);
              },
              fillColor: MaterialStateColor.resolveWith(
                (states) => Colors.red,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextUtils(
                  fontWeight: FontWeight.bold,
                  text: title,
                  color: Colors.black,
                  fontSize: 20,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextUtils(
                  fontWeight: FontWeight.normal,
                  text: name,
                  color: Colors.black,
                  fontSize: 15,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text("🇯🇴+962 "),
                    TextUtils(
                      fontWeight: FontWeight.normal,
                      text: phone,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    const SizedBox(
                      width: 120,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextUtils(
                  fontWeight: FontWeight.bold,
                  text: address,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
