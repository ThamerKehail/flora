import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_home_page/main_home_page.dart';
import '../main_home_page/main_home_view_model.dart';

class OtpPage extends StatefulWidget {
  final String? verificationId;

  final bool isTimeOut2;
  const OtpPage({
    Key? key,
    this.verificationId,
    required this.isTimeOut2,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool showLoading = false;
  String verificationFailedMessage = "";
  final otpController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String myVerificationId = '';
  bool isTimeOut = false;
  @override
  void initState() {
    super.initState();
    myVerificationId = widget.verificationId!;
    isTimeOut = widget.isTimeOut2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: showLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Spacer(),
                    TextField(
                      controller: otpController,
                      decoration: const InputDecoration(hintText: 'Enter OTP'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff025a97)),
                        onPressed: isTimeOut
                            ? null
                            : () async {
                                setState(() {
                                  showLoading = true;
                                });
                                try {
                                  PhoneAuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: myVerificationId,
                                          smsCode: otpController.text);

                                  // Sign the user in (or link) with the credential
                                  await auth.signInWithCredential(credential);
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    verificationFailedMessage =
                                        e.message ?? "error";
                                  });
                                }
                                setState(() {
                                  showLoading = false;
                                });
                                if (auth.currentUser != null) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                create: (_) =>
                                                    MainHomeViewModel(),
                                                child: const MainHomepage(),
                                              )));
                                }
                              },
                        child: const Text(
                          "VERIFY",
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: isTimeOut
                            ? () async {
                                setState(() {
                                  isTimeOut = false;
                                });
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  timeout: const Duration(seconds: 10),
                                  phoneNumber: '+962786007814',
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  verificationFailed:
                                      (FirebaseAuthException e) {
                                    setState(() {
                                      showLoading = false;
                                    });
                                    setState(() {
                                      verificationFailedMessage =
                                          e.message ?? "error";
                                    });
                                  },
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    setState(() {
                                      showLoading = false;
                                      myVerificationId = verificationId;
                                    });
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {
                                    setState(() {
                                      isTimeOut = true;
                                    });
                                  },
                                );
                              }
                            : null,
                        child: Text(
                          "send the code again",
                          style: TextStyle(
                              color: isTimeOut
                                  ? const Color(0xff025a97)
                                  : Colors.grey),
                        )),
                    const SizedBox(
                      height: 100,
                    ),
                    const Spacer(),
                  ],
                ),
              ));
  }
}
