// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ward/utils/const.dart';
// import 'package:ward/utils/location_service.dart';
// import 'package:ward/utils/routes.dart';
//
// class LocationPermeationViewModel extends ChangeNotifier {
//   String? lat, long, country, adminArea;
//   final navigatorKey = GlobalKey<NavigatorState>();
//   void alertLocation(BuildContext context) {
//     showDialog<String>(
//       context: navigatorKey.currentContext ?? context,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('Permeation Location'),
//         content: const Text(
//             'Flora App collects location data to enable the identification of nearby Shops even when the app is closed or not in use.'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'Cancel'),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               final service = LocationService();
//               service.location.serviceEnabled();
//               service.grantedPermission = PermissionStatus.granted;
//               notifyListeners();
//               getLocation(context);
//               // Navigator.pop(context);
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   bool loading = false;
//
//   getLocation(BuildContext context) async {
//     loading = true;
//     notifyListeners();
//
//     final service = LocationService();
//
//     final locationData = await service.getLocation();
//     print(await service.checkPermission());
//     if (await service.checkPermission() != PermissionStatus.deniedForever) {
//       final placeMark = await service.getPlaceMark(locationData: locationData);
//       lat = locationData.latitude!.toString();
//       long = locationData.longitude!.toString();
//       country = placeMark.country ?? 'could no`t get country ';
//       adminArea = placeMark.administrativeArea ?? 'could no`t get adminArea ';
//       //print(await service.checkPermission());
//       Navigator.of(context).pushReplacementNamed(AppRoutes.mainHomeScreen);
//       loading = false;
//       print('locationData ======= $locationData');
//       print(await service.checkPermission());
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       preferences.setBool('setLocation', true);
//       isSetLocation = true;
//     } else {
//       loading = false;
//       notifyListeners();
//       alertLocation(context);
//       print("hhhhhhhhhhhhhhhhh");
//     }
//
//     notifyListeners();
//   }
// }
