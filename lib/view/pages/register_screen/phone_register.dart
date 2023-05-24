//  // import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:ward/utils/language_constant.dart';
// import 'package:ward/utils/theme.dart';
// import 'package:ward/view/pages/register_screen/otp_screen.dart';
// import 'package:ward/view/widget/auth_widget/auth_button.dart';
//
// import '../../widget/text_utils.dart';
//
// class PhoneRegister extends StatefulWidget {
//   const PhoneRegister({Key? key}) : super(key: key);
//
//   @override
//   State<PhoneRegister> createState() => _PhoneRegisterState();
// }
//
// class _PhoneRegisterState extends State<PhoneRegister> {
//   final GlobalKey _formKey = GlobalKey();
//   bool showLoading = false;
//
//   final phoneEditingController = TextEditingController();
//   // String countryCode = '';
//   String verificationFailedMessage = "";
//   String countryCode = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return showLoading
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : Scaffold(
//             backgroundColor: Colors.white,
//             appBar: PreferredSize(
//               preferredSize: const Size.fromHeight(130),
//               child: AppBar(
//                 elevation: 0,
//                 backgroundColor: Colors.white,
//                 automaticallyImplyLeading: false,
//                 flexibleSpace: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     IconButton(
//                       padding: const EdgeInsets.only(left: 16, bottom: 30),
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.arrow_back_ios,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     right: 16, left: 16, top: 120, bottom: 44),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               TextUtils(
//                                   fontWeight: FontWeight.w500,
//                                   text: translation(context).sign,
//                                   color: mainColor,
//                                   fontSize: 26),
//                               const SizedBox(
//                                 width: 3,
//                               ),
//                               TextUtils(
//                                   fontWeight: FontWeight.w500,
//                                   text: translation(context).up,
//                                   color: Colors.black,
//                                   fontSize: 26),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 48,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               TextUtils(
//                                 text: translation(context).phoneNumber,
//                                 fontSize: 14,
//                                 color: Colors.grey.shade900,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               SizedBox(
//                                 height: 70,
//                                 child: IntlPhoneField(
//                                   decoration: InputDecoration(
//                                     fillColor: Colors.grey.shade200,
//                                     filled: true,
//                                     enabledBorder: OutlineInputBorder(
//                                         borderSide: const BorderSide(
//                                           color: Colors.white,
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     border: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Colors.white,
//                                       ),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     errorBorder: OutlineInputBorder(
//                                         borderSide: const BorderSide(
//                                           color: Colors.white,
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     focusedErrorBorder: OutlineInputBorder(
//                                         borderSide: const BorderSide(
//                                           color: Colors.white,
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide: const BorderSide(
//                                           color: Colors.white,
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                   ),
//                                   initialCountryCode: 'JO',
//                                   dropdownIcon: Icon(
//                                     Icons.arrow_drop_down_outlined,
//                                     color: mainColor,
//                                   ),
//                                   onChanged: (phone) {
//                                     countryCode = phone.completeNumber;
//                                   },
//                                   onSubmitted: (phone) {
//                                     setState(() {
//                                       countryCode = phone;
//                                     });
//
//                                     // countryCode = phone.tr;
//                                     // print(phone.completeNumber);
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 38,
//                           ),
//                           AuthButton(
//                               text: translation(context).send,
//                               onPressed: () async {
//                                 setState(() {
//                                   showLoading = true;
//                                 });
//                                 await FirebaseAuth.instance.verifyPhoneNumber(
//                                   timeout: const Duration(seconds: 60),
//                                   phoneNumber: countryCode,
//                                   verificationCompleted:
//                                       (PhoneAuthCredential credential) {},
//                                   verificationFailed:
//                                       (FirebaseAuthException e) {
//                                     setState(() {
//                                       showLoading = false;
//                                     });
//                                     setState(() {
//                                       verificationFailedMessage =
//                                           e.message ?? "error";
//                                     });
//                                   },
//                                   codeSent: (String verificationId,
//                                       int? resendToken) {
//                                     setState(() {
//                                       showLoading = false;
//                                     });
//                                     Navigator.of(context).pushReplacement(
//                                         PageRouteBuilder(
//                                             pageBuilder: (_, __, ___) =>
//                                                 OtpScreen(
//                                                   number: countryCode,
//                                                   isTimeOut2: false,
//                                                   verificationId:
//                                                       verificationId,
//                                                 )));
//                                   },
//                                   codeAutoRetrievalTimeout:
//                                       (String verificationId) {
//                                     Navigator.of(context).pushReplacement(
//                                         PageRouteBuilder(
//                                             pageBuilder: (_, __, ___) =>
//                                                 OtpScreen(
//                                                   number: countryCode,
//                                                   isTimeOut2: true,
//                                                   verificationId:
//                                                       verificationId,
//                                                 )));
//                                   },
//                                 );
//                               }),
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           Text(verificationFailedMessage),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/register_screen/otp_screen.dart';
import 'package:ward/view/pages/register_screen/register_view_model.dart';

class PhoneRegister extends StatefulWidget {
  const PhoneRegister({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<PhoneRegister> createState() => _PhoneRegisterState();
}

class _PhoneRegisterState extends State<PhoneRegister> {
  TextEditingController countryController = TextEditingController();
  var phone = "";
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+962";

    super.initState();
    Future.microtask(() => context.read<RegisterViewModel>().getAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/otp.gif',
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  translation(context).phoneVerify,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  translation(context).needRegister,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextFormField(
                        validator: (value) {
                          if (value!.length != 9) {
                            return "Phone number is not valid";
                          }
                        },
                        onChanged: (value) {
                          phone = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        Provider.of<RegisterViewModel>(context, listen: false)
                            .setLoading(true);
                        if (_formKey.currentState!.validate()) print(phone);
                        {
                          print(countryController.text + phone);
                          (users.allUsers.indexWhere((element) =>
                                      element.mobile ==
                                      countryController.text + phone) ==
                                  -1)
                              ? await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: countryController.text + phone,
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  verificationFailed:
                                      (FirebaseAuthException e) {},
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    PhoneRegister.verify = verificationId;
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (_) => OtpScreen(
                                                  phoneNumber:
                                                      countryController.text +
                                                          phone,
                                                  index: 1,
                                                )));
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {
                                    print(verificationId);
                                  },
                                )
                              : users.snackBar(
                                  "Phone is already Register ", context);
                        }
                      },
                      child:
                          Provider.of<RegisterViewModel>(context, listen: false)
                                      .loading ==
                                  true
                              ? CircularProgressIndicator()
                              : Text(translation(context).sendCode)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
