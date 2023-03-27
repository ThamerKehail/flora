// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:ward/view/pages/location_permeation_page/location_permeation_view_model.dart';
// import 'package:ward/view/widget/auth_widget/auth_button.dart';
//
// class LocationPermeationPage extends StatelessWidget {
//   const LocationPermeationPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final locationPermeation = context.watch<LocationPermeationViewModel>();
//
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Lottie.asset(
//             'assets/images/location.json',
//             height: 350,
//             width: 350,
//           ),
//           Text(
//             'Flora App collects location data to enable the identification of nearby Shops even when the app is closed or not in use.',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           Text(
//             "Start with sharing \n your location with us",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//           locationPermeation.loading == false
//               ? AuthButton(
//                   text: 'Enable',
//                   onPressed: () {
//                     locationPermeation.getLocation(context);
//                   })
//               : CircularProgressIndicator(),
//         ],
//       ),
//     );
//   }
// }
