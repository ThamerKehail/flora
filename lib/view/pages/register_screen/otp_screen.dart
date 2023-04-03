// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:ward/utils/language_constant.dart';
// import 'package:ward/utils/theme.dart';
// import 'package:ward/view/pages/register_screen/register_screen.dart';
//
// class OtpScreen extends StatefulWidget {
//   final String verificationId;
//   final String number;
//
//   final bool isTimeOut2;
//   const OtpScreen(
//       {Key? key,
//       required this.verificationId,
//       required this.isTimeOut2,
//       required this.number})
//       : super(key: key);
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   bool showLoading = false;
//   String verificationFailedMessage = "";
//   final otpController = TextEditingController();
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   String myVerificationId = '';
//   bool isTimeOut = false;
//   bool hasError = false;
//   String currentText = "";
//   final formKey = GlobalKey<FormState>();
//   StreamController<ErrorAnimationType>? errorController;
//
//   @override
//   void initState() {
//     super.initState();
//     myVerificationId = widget.verificationId;
//     isTimeOut = widget.isTimeOut2;
//   }
//
//   snackBar(String? message) {
//     return ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message!),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {},
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: ListView(
//             children: <Widget>[
//               const SizedBox(height: 30),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 3,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(30),
//                   child: Image.asset('assets/images/otp.gif'),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   translation(context).phoneVerify,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 22),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
//                 child: RichText(
//                   text: TextSpan(
//                       text: translation(context).enterCode,
//                       children: [
//                         TextSpan(
//                             text: widget.number,
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15)),
//                       ],
//                       style:
//                           const TextStyle(color: Colors.black54, fontSize: 15)),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Form(
//                 key: formKey,
//                 child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 30),
//                     child: PinCodeTextField(
//                       appContext: context,
//                       pastedTextStyle: TextStyle(
//                         color: mainColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       length: 6,
//                       obscureText: true,
//                       obscuringCharacter: '*',
//                       obscuringWidget: Icon(
//                         Icons.done,
//                         color: mainColor,
//                       ),
//                       blinkWhenObscuring: true,
//                       animationType: AnimationType.fade,
//                       validator: (v) {
//                         if (v!.length < 6) {
//                           return "I'm from validator";
//                         } else {
//                           return null;
//                         }
//                       },
//                       pinTheme: PinTheme(
//                         disabledColor: Colors.yellow,
//                         inactiveColor: Colors.grey,
//                         inactiveFillColor: Colors.white,
//                         selectedFillColor: Colors.white,
//                         selectedColor: mainColor,
//                         activeColor: mainColor,
//                         shape: PinCodeFieldShape.box,
//                         borderRadius: BorderRadius.circular(5),
//                         fieldHeight: 50,
//                         fieldWidth: 40,
//                         activeFillColor: Colors.white,
//                       ),
//                       cursorColor: Colors.black,
//                       animationDuration: const Duration(milliseconds: 300),
//                       enableActiveFill: true,
//                       errorAnimationController: errorController,
//                       controller: otpController,
//                       keyboardType: TextInputType.number,
//                       boxShadows: const [
//                         BoxShadow(
//                           offset: Offset(0, 1),
//                           color: Colors.black12,
//                           blurRadius: 10,
//                         )
//                       ],
//                       onCompleted: (v) {
//                         debugPrint("Completed");
//                       },
//                       // onTap: () {
//                       //   print("Pressed");
//                       // },
//                       onChanged: (value) {
//                         debugPrint(value);
//                         setState(() {
//                           currentText = value;
//                         });
//                       },
//                       beforeTextPaste: (text) {
//                         debugPrint("Allowing to paste $text");
//                         //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                         //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                         return true;
//                       },
//                     )),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: Text(
//                   hasError ? "*Please fill up all the cells properly" : "",
//                   style: TextStyle(
//                       color: mainColor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     translation(context).receiveCode,
//                     style: const TextStyle(color: Colors.black54, fontSize: 15),
//                   ),
//                   TextButton(
//                     onPressed: isTimeOut
//                         ? () async {
//                             setState(() {
//                               isTimeOut = false;
//                             });
//                             await FirebaseAuth.instance.verifyPhoneNumber(
//                               timeout: const Duration(seconds: 10),
//                               phoneNumber: widget.number,
//                               verificationCompleted:
//                                   (PhoneAuthCredential credential) {
//                                 print("gghghghgh");
//                               },
//                               verificationFailed: (FirebaseAuthException e) {
//                                 setState(() {
//                                   showLoading = false;
//                                 });
//                                 setState(() {
//                                   verificationFailedMessage =
//                                       e.message ?? "error";
//                                 });
//                               },
//                               codeSent:
//                                   (String verificationId, int? resendToken) {
//                                 setState(() {
//                                   showLoading = false;
//                                   myVerificationId = verificationId;
//                                 });
//                               },
//                               codeAutoRetrievalTimeout:
//                                   (String verificationId) {
//                                 setState(() {
//                                   isTimeOut = true;
//                                 });
//                               },
//                             );
//                             snackBar("OTP resend!!");
//                           }
//                         : null,
//                     child: Text(
//                       translation(context).resend,
//                       style: TextStyle(
//                           color: mainColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 14,
//               ),
//               Container(
//                 margin:
//                     const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
//                 decoration: BoxDecoration(
//                     color: mainColor,
//                     borderRadius: BorderRadius.circular(5),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey.shade200,
//                           offset: const Offset(1, -2),
//                           blurRadius: 5),
//                       BoxShadow(
//                           color: Colors.grey.shade200,
//                           offset: const Offset(-1, 2),
//                           blurRadius: 5)
//                     ]),
//                 child: ButtonTheme(
//                   height: 50,
//                   child: TextButton(
//                     onPressed: isTimeOut
//                         ? () {
//                             snackBar("Time out");
//                           }
//                         : () async {
//                             setState(() {
//                               showLoading = true;
//                             });
//                             try {
//                               formKey.currentState!.validate();
//                               // conditions for validating
//                               if (currentText.length != 6) {
//                                 errorController!.add(ErrorAnimationType
//                                     .shake); // Triggering error shake animation
//                                 setState(() => hasError = true);
//                               } else {
//                                 signIn(currentText);
//                                 setState(
//                                   () {
//                                     hasError = false;
//                                   },
//                                 );
//                                 setState(() {
//                                   showLoading = true;
//                                 });
//
//                                 try {} on FirebaseAuthException catch (e) {
//                                   setState(() {
//                                     verificationFailedMessage =
//                                         e.message ?? "error";
//                                   });
//                                 }
//
//                                 setState(() {
//                                   showLoading = false;
//                                 });
//                                 if (auth.currentUser != null) {
//                                   Navigator.of(context).push(PageRouteBuilder(
//                                       pageBuilder: (_, __, ___) =>
//                                           RegisterScreen()));
//                                 }
//                               }
//                             } on FirebaseAuthException catch (e) {
//                               setState(() {
//                                 verificationFailedMessage =
//                                     e.message ?? "error";
//                               });
//                             }
//                             setState(() {
//                               showLoading = false;
//                             });
//                             if (auth.currentUser!.emailVerified) {
//                               // ignore: use_build_context_synchronously
//                               Navigator.of(context).pushReplacement(
//                                 MaterialPageRoute(
//                                   builder: (_) => RegisterScreen(
//                                     mobile: widget.number,
//                                   ),
//                                 ),
//                               );
//                             }
//                           },
//                     child: Center(
//                         child: Text(
//                       translation(context).verify,
//                       style: TextStyle(
//                           color: isTimeOut ? Colors.black : Colors.red,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     )),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Flexible(
//                       child: TextButton(
//                     child: const Text("Clear"),
//                     onPressed: () {
//                       otpController.clear();
//                     },
//                   )),
//                   Flexible(
//                       child: TextButton(
//                     child: const Text("Set Text"),
//                     onPressed: () {
//                       setState(() {
//                         otpController.text = "123456";
//                       });
//                     },
//                   )),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> signIn(String otp) async {
//     await FirebaseAuth.instance
//         .signInWithCredential(PhoneAuthProvider.credential(
//       verificationId: widget.verificationId,
//       smsCode: otp,
//     ));
//   }
// }
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/edit_password/edit_password.dart';
import 'package:ward/view/pages/register_screen/phone_register.dart';
import 'package:ward/view/pages/register_screen/register_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final int index;
  const OtpScreen({Key? key, required this.phoneNumber, required this.index})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    // final defaultPinTheme = PinTheme(
    //   width: 56,
    //   height: 56,
    //   textStyle: TextStyle(
    //       fontSize: 20,
    //       color: Color.fromRGBO(30, 60, 87, 1),
    //       fontWeight: FontWeight.w600),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    // );

    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
    //   borderRadius: BorderRadius.circular(8),
    // );
    //
    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: Color.fromRGBO(234, 239, 243, 1),
    //   ),
    // );
    // var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/otp.gif',
              ),
              Text(widget.phoneNumber),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      obscuringWidget:
                          Image.asset('assets/images/flora_logo.png'),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 6) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        activeColor: mainColor,
                        selectedColor: Colors.white,
                        inactiveColor: Colors.white,
                        disabledColor: Colors.white,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,

                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) async {
                        debugPrint("Completed $currentText");
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: PhoneRegister.verify,
                            smsCode: currentText,
                          );
                          await auth.signInWithCredential(credential);
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (_) => widget.index == 1
                                      ? RegisterScreen(
                                          mobile: widget.phoneNumber,
                                        )
                                      : EditPassword()));
                        } catch (e) {
                          snackBar("Please check OTP");
                        }
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              // Pinput(
              //   length: 6,
              //   // defaultPinTheme: defaultPinTheme,
              //   // focusedPinTheme: focusedPinTheme,
              //   // submittedPinTheme: submittedPinTheme,
              //
              //   showCursor: true,
              //   onCompleted: (pin) => print(pin),
              //   onChanged: (value) {
              //     code = value;
              //   },
              // ),
              SizedBox(
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
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: PhoneRegister.verify,
                          smsCode: currentText,
                        );
                        await auth.signInWithCredential(credential);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => widget.index == 1
                                ? RegisterScreen(
                                    mobile: widget.phoneNumber,
                                  )
                                : EditPassword()));
                      } catch (e) {
                        snackBar("Please check OTP");
                      }
                    },
                    child: Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.phoneRegisterScreen);
                      },
                      child: Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  snackBar(
    String? message,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
