import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/view/pages/edit_profile/edit_profile_view_model.dart';
import 'package:ward/view/pages/main_home_page/main_home_page.dart';
import '../../../models/user_model.dart';
import '../../widget/profile_widget/build_appbar.dart';
import '../../widget/profile_widget/button_widget.dart';
import '../../widget/profile_widget/textfield_widget.dart';
import '../profile_page/profile_view_model.dart';

class EditProfilePage extends StatefulWidget {
  final String fName;
  final String lName;
  final String email;
  final String image;

  const EditProfilePage({
    super.key,
    required this.fName,
    required this.lName,
    required this.email,
    required this.image,
  });
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    Future.microtask(() => context
        .read<EditProfileViewModel>()
        .downloadAndSavePhoto(widget.image));
    super.initState();
  }

  File? _image;
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final editProfile = context.watch<EditProfileViewModel>();
    final user = context.watch<ProfileViewModel>();

    fNameController.text = widget.fName;
    lNameController.text = widget.lName;
    emailController.text = widget.email;

    return Builder(
      builder: (context) => Scaffold(
        appBar: buildAppBar(context),
        body: FutureBuilder<List<Client>>(
            future: user.user,
            builder: (context, snapshot) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                physics: const BouncingScrollPhysics(),
                children: [
                  InkWell(
                    onTap: () {
                      _onPlusClick(context);
                    },
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 65,
                        backgroundImage: _image == null
                            ? NetworkImage(
                                widget.image,
                              )
                            : FileImage(File(_image!.path)) as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    label: translation(context).firstName,
                    text: '',
                    controller: fNameController,
                    onChanged: (name) {},
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    label: translation(context).lastName,
                    text: 'Last Name',
                    controller: lNameController,
                    onChanged: (name) {},
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    label: translation(context).email,
                    text: 'Email',
                    controller: emailController,
                    onChanged: (email) {},
                  ),
                  const SizedBox(height: 24),
                  ButtonWidget(
                    text: translation(context).save,
                    onClicked: () async {
                      // if (_image == null) {
                      //   snackBar("Image is required");
                      //   Navigator.pop(context);
                      // }
                      editProfile.editProfile(
                          fName: fNameController.text.isEmpty
                              ? snapshot.data![0].fname!
                              : fNameController.text,
                          lName: lNameController.text.isEmpty
                              ? snapshot.data![0].lname!
                              : lNameController.text,
                          email: emailController.text.isEmpty
                              ? snapshot.data![0].email!
                              : emailController.text,
                          img: _image ??
                              (Provider.of<EditProfileViewModel>(context,
                                      listen: false)
                                  .imageData!));
                      Future.delayed(
                        Duration(seconds: 2),
                        () => Navigator.of(context)
                            .pushNamed(AppRoutes.mainHomeScreen),
                      );

                      // await Future.microtask(() =>
                      //         context.read<ProfileViewModel>().getUserInfo())
                      //     .then((value) => Navigator.of(context)
                      //         .pushNamed(AppRoutes.mainHomeScreen));
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }

  void _onPlusClick(BuildContext context) {
    final action = showAdaptiveActionSheet(
        cancelAction: CancelAction(
            title: const Text(
                'Cancel')), // onPressed parameter is optional by default will dismiss the ActionSheet
        androidBorderRadius: 30,
        context: context,
        title: const Text("Upload Image"),
        actions: <BottomSheetAction>[
          BottomSheetAction(
            title: const Text("open Gallery"),
            onPressed: (context) async {
              Navigator.pop(context);
              XFile? image =
                  await _imagePicker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  _image = File(image.path);
                });
                print("_image= " + _image!.path.split('/').last);
              }
            },
          ),
        ]);
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
