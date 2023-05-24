import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/view/pages/edit_password/edit_password_view_model.dart';

import '../../../utils/global.dart';
import '../../../utils/routes.dart';
import '../../../utils/theme.dart';
import '../../widget/profile_widget/button_widget.dart';
import '../../widget/profile_widget/textfield_widget.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  TextEditingController password = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final editPassword = context.watch<EditPasswordViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          translation(context).editPassword,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldWidget(
                label: translation(context).oldPassword,
                text: 'Password',
                controller: oldPassword,
                onChanged: (name) async {},
                validator: (value) {
                  if (value.toString() != oldPass) {
                    return translation(context).enterRightPass;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFieldWidget(
                label: translation(context).newPass,
                text: 'Password',
                controller: password,
                onChanged: (name) {},
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return translation(context).enterPassMore;
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translation(context).confirmPass,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: confirmPassword,
                    validator: (value) {
                      if (confirmPassword.text != password.text) {
                        return translation(context).checkConfirm;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ButtonWidget(
                text: translation(context).save,
                onClicked: () {
                  print(oldPass);
                  if (_formKey.currentState!.validate()) {
                    print("change Password");
                    editPassword.editPassword(password: password.text);
                    Navigator.of(context).pushNamed(AppRoutes.mainHomeScreen);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
