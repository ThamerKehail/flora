import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ward/view/pages/login_page/login_page.dart';
import 'package:ward/view/pages/register_screen/register_view_model.dart';

import '../../../utils/language_constant.dart';
import '../../../utils/theme.dart';
import '../../widget/auth_widget/auth_button.dart';
import '../../widget/auth_widget/auth_text_form_field.dart';
import '../../widget/auth_widget/container_under.dart';
import '../../widget/text_utils.dart';

class RegisterScreen extends StatefulWidget {
  //new
  final String mobile;
  const RegisterScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final register = context.watch<RegisterViewModel>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25, top: 25, bottom: 50),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              'assets/images/logo_flora.svg',
                              width: 120,
                              color: Color(0xff14191e),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              TextUtils(
                                  fontWeight: FontWeight.w500,
                                  text: translation(context).sign,
                                  color: mainColor,
                                  fontSize: 26),
                              const SizedBox(
                                width: 3,
                              ),
                              TextUtils(
                                  fontWeight: FontWeight.w500,
                                  text: translation(context).up,
                                  color: Colors.black,
                                  fontSize: 26),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(widget.mobile),
                          AuthTextFormField(
                            controller: fNameController,
                            obscure: false,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter a valid name";
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: mainColor,
                              size: 35,
                            ),
                            hintText: translation(context).firstName,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthTextFormField(
                            controller: lNameController,
                            obscure: false,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter a valid name";
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: mainColor,
                              size: 35,
                            ),
                            hintText: translation(context).lastName,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthTextFormField(
                            controller: emailController,
                            obscure: false,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter a valid email";
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: mainColor,
                              size: 35,
                            ),
                            hintText: translation(context).email,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          AuthTextFormField(
                            controller: passwordController,
                            type: TextInputType.text,
                            obscure: register.visibilityPassword ? false : true,
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
                                register.visibilityChange();
                              },
                              icon: Icon(
                                register.visibilityPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: mainColor,
                              ),
                            ),
                            hintText: translation(context).password,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          AuthTextFormField(
                            controller: confirmPasswordController,
                            type: TextInputType.text,
                            obscure: register.visibilityConfirmPassword
                                ? false
                                : true,
                            validator: (value) {
                              if (value.toString().length < 6 &&
                                  passwordController !=
                                      confirmPasswordController) {
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
                                register.visibilityChangeConfirmPassword();
                              },
                              icon: Icon(
                                register.visibilityConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: mainColor,
                              ),
                            ),
                            hintText: translation(context).confirmPass,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          AuthButton(
                              text: 'Sign Up',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  register.register(
                                    mobile: widget.mobile,
                                    profileImg: "",
                                    lname: lNameController.text,
                                    fname: fNameController.text,
                                    password: passwordController.text,
                                    email: emailController.text,
                                    context: context,
                                  );
                                }
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ContainerUnder(
                  text: 'I have an Account? ',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                  },
                  textType: 'Log In',
                )
              ],
            ),
          ),
        ));
  }
}
