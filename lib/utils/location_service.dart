// import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart' as goa;
// import 'package:location/location.dart';
//
// class LocationService {
//   late Location location;
//   bool _serviceEnabled = false;
//   PermissionStatus? grantedPermission;
//   String? lat, long, country, adminArea;
//   LocationService() {
//     location = Location();
//   }
//
//   Future<PermissionStatus> checkPermission() async {
//     if (await _checkServices()) {
//       grantedPermission = await location.hasPermission();
//       if (grantedPermission != PermissionStatus.granted) {
//         grantedPermission = await location.requestPermission();
//       }
//     }
//     return grantedPermission!;
//   }
//
//   Future<bool> _checkServices() async {
//     try {
//       _serviceEnabled = await location.serviceEnabled();
//       if (!_serviceEnabled) {
//         _serviceEnabled = await location.requestService();
//       }
//     } on PlatformException catch (error) {
//       print('error code is ${error.code} and message= ${error.message}');
//       _serviceEnabled = false;
//       await _checkServices();
//     }
//     return _serviceEnabled;
//   }
//
//   getLocation() async {
//     if (await checkPermission() == PermissionStatus.granted ||
//         checkPermission() == PermissionStatus.grantedLimited) {
//       final locationData = location.getLocation();
//       return locationData;
//     }
//     return location.serviceEnabled();
//   }
//
//   Future<goa.Placemark> getPlaceMark(
//       {required LocationData locationData}) async {
//     final List<goa.Placemark> placeMark = await goa.placemarkFromCoordinates(
//         locationData.latitude!, locationData.longitude!);
//     if (placeMark != null && placeMark.isNotEmpty) {
//       return placeMark[0];
//     }
//     return null!;
//   }
// }
