import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/global.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/pages/forget_password/phone_forget_password.dart';
import 'package:ward/view/widget/auth_widget/auth_button.dart';
import 'package:ward/view/widget/auth_widget/auth_text_form_field.dart';
import 'package:ward/view/widget/auth_widget/container_under.dart';
import 'package:ward/view/widget/text_utils.dart';

import 'login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  String countryCode = '';
  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    final login = context.watch<LoginViewModel>();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 25, top: 25, bottom: 110),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'assets/images/logo_flora.svg',
                                width: 120,
                                color: Color(0xff14191e),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            TextUtils(
                                fontWeight: FontWeight.w500,
                                text: translation(context).log,
                                color: mainColor,
                                fontSize: 26),
                            const SizedBox(
                              width: 3,
                            ),
                            TextUtils(
                                fontWeight: FontWeight.w500,
                                text: translation(context).inLog,
                                color: Color(0xff14191e),
                                fontSize: 26),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 70,
                          child: IntlPhoneField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            initialCountryCode: 'JO',
                            dropdownIcon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: mainColor,
                            ),
                            onChanged: (phone) {
                              countryCode = phone.completeNumber;
                            },
                            onSubmitted: (phone) {
                              setState(() {
                                countryCode = phone;
                              });

                              // countryCode = phone.tr;
                              // print(phone.completeNumber);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AuthTextFormField(
                          controller: passwordController,
                          type: TextInputType.text,
                          obscure: login.visibility ? false : true,
                          validator: (value) {
                            if (value.toString().length < 6) {
                              return "Password should be longer or equal to 6 char ";
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icon(
                            Icons.lock_open_outlined,
                            color: mainColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              login.visibilityChange();
                            },
                            icon: Icon(
                              login.visibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: mainColor,
                            ),
                          ),
                          hintText: translation(context).password,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (MaterialPageRoute) =>
                                    const PhoneForgetPassword()));
                          },
                          child: TextUtils(
                              fontWeight: FontWeight.normal,
                              text: translation(context).forgetPassword,
                              color: Colors.grey,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthButton(
                            text:
                                '${translation(context).log} ${translation(context).inLog}',
                            onPressed: () async {
                              print(messageUser);
                              if (_formKey.currentState!.validate()) {
                                login.login(
                                  mobile: countryCode,
                                  password: passwordController.text,
                                  context: context,
                                );
                                Future.delayed(
                                  Duration(seconds: 1),
                                  () async {
                                    await messageUser == false
                                        ? AwesomeDialog(
                                            context: context,
                                            btnCancel: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("cancel")),
                                            title: 'Check',
                                            body: const Text(
                                              "Email or Password  not valid or account is not found",
                                              textAlign: TextAlign.center,
                                            )).show()
                                        : SizedBox();
                                  },
                                );
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        // Align(
                        //   alignment: Alignment.center,
                        //   child: TextUtils(
                        //       fontWeight: FontWeight.w500,
                        //       text: translation(context).or,
                        //       color: mainColor,
                        //       fontSize: 18),
                        // ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     final provider = Provider.of<GoogleSignInProvider>(
                        //         context,
                        //         listen: false);
                        //     provider.googleLogin();
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       SvgPicture.asset(
                        //         'assets/icons/google-icon.svg',
                        //         width: 30,
                        //         height: 30,
                        //       ),
                        //       const SizedBox(
                        //         width: 5,
                        //       ),
                        //       TextUtils(
                        //           fontWeight: FontWeight.w500,
                        //           text: translation(context).continueGoogle,
                        //           color: mainColor,
                        //           fontSize: 18),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              ContainerUnder(
                text: translation(context).createAccount,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.phoneRegisterScreen);
                },
                textType:
                    '${translation(context).sign} ${translation(context).up}',
              )
            ],
          ),
        ));
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
