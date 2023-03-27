import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/view/pages/edit_password/edit_password_view_model.dart';

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
  TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final editPassword = context.watch<EditPasswordViewModel>();

    return Scaffold(
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Spacer(),
            Text(
              "Edit Password",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Spacer(),
          ],
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
                label: translation(context).newPass,
                text: 'Password',
                controller: password,
                onChanged: (name) {},
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
                        return "Please Check Confirm Password";
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
                  if (_formKey.currentState!.validate()) {
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
