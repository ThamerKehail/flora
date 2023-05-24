//  // import 'package:flutter/material.dart';
// import 'package:ward/view/pages/login_page/login_page.dart';
//
// import '../../utils/global.dart';
// import 'loggedWidget.dart';
//
// class HomeGoogleInfo extends StatelessWidget {
//   const HomeGoogleInfo({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     print("objectbbbbbbbbbbbbb");
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return LoggedWidget();
//           } else {
//             return const LoginPage();
//           }
//         },
//       ),
//     );
//   }
// }
