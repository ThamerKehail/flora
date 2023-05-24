import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/routes.dart';

import '../cart_page/cart_view_model.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context);

    cart.phone.clear();
    cart.note.clear();
    cart.city.clear();
    cart.addressText.clear();
    cart.street.clear();
    cart.building.clear();
    cart.floor.clear();
    cart.currentStep = 0;
    cart.activeStep = 0;
    cart.currentStep_ = 0;
    cart.clear();
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/flora_payment.jpg'),
          SizedBox(
            height: 70,
          ),
          SvgPicture.asset(
            'assets/images/checkmark.svg',
            color: Color(0xff1073930),
            width: 40,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "${translation(context).orderSuccess} !",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              translation(context).contactYou,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.mainHomeScreen);
            },
            child: Container(
              width: 150,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xff1073930),
              ),
              child: Center(
                child: Text(
                  translation(context).home,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
