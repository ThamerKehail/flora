import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/models/user_model.dart';
import 'package:ward/utils/routes.dart';
import 'package:ward/view/pages/profile_page/profile_view_model.dart';

import '../../../main.dart';
import '../../../models/language.dart';
import '../../../utils/const.dart';
import '../../../utils/language_constant.dart';
import '../../../utils/theme.dart';
import '../../widget/profile_widget/button_widget.dart';
import '../../widget/profile_widget/profile_icon_widget.dart';
import '../../widget/profile_widget/profile_widget.dart';
import '../edit_profile/edit_profile.dart';
import '../login_page/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<ProfileViewModel>().getUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileViewModel>();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<Client>>(
                  future: user.user,
                  builder: (context, snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.data!.isEmpty) {
                      return Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/flora_cover.png'),
                                fit: BoxFit.fitWidth)),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ProfileWidget(
                          imagePath: snapshot.data![0].profileImage == 'na'
                              ? 'https://cdn-icons-png.flaticon.com/512/3024/3024605.png'
                              : "$url/${snapshot.data![0].profileImage}",
                          onClicked: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage()),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        buildName(
                            email: snapshot.data![0].email!,
                            name:
                                "${snapshot.data![0].fname!} ${snapshot.data![0].lname}"),
                      ],
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(
                height: 35,
              ),
              userId == 0
                  ? SizedBox()
                  : ProfileIconWidget(
                      image: "assets/images/settings.png",
                      text: translation(context).editProfile,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditProfilePage()));
                      },
                    ),
              userId == 0
                  ? SizedBox()
                  : const SizedBox(
                      height: 35,
                    ),
              userId == 0
                  ? SizedBox()
                  : ProfileIconWidget(
                      image: "assets/images/unlock.png",
                      text: translation(context).changePassword,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.editPasswordScreen);
                      },
                    ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ProfileIconWidget(
                      image: "assets/images/internet.png",
                      text: translation(context).changeLanguage,
                      onTap: () {},
                    ),
                  ),
                  DropdownButton<Language>(
                    underline: const SizedBox(),
                    icon: Icon(
                      Icons.arrow_circle_down_sharp,
                      color: mainColor,
                    ),
                    onChanged: (Language? language) async {
                      if (language != null) {
                        Locale locale = await setLocale(language.languageCode);
                        // ignore: use_build_context_synchronously
                        MyApp.setLocale(context, locale);
                      }
                    },
                    items: Language.languageList()
                        .map<DropdownMenuItem<Language>>(
                          (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  e.flag,
                                  style: const TextStyle(fontSize: 30),
                                ),
                                Text(e.name)
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              userId == 0
                  ? SizedBox()
                  : ProfileIconWidget(
                      image: "assets/images/review.png",
                      text: translation(context).rateBusiness,
                      onTap: () async {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.allRateUsScreen);
                      },
                    ),
              const SizedBox(
                height: 35,
              ),
              userId == 0
                  ? SizedBox()
                  : ProfileIconWidget(
                      image: "assets/images/remove-user.png",
                      text: translation(context).deleteAccount,
                      onTap: () async {
                        String status;
                        status = await user.deleteAccount();
                        if (status == "Success") {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt('userId', 0);
                          userId = 0;
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.mainHomeScreen);
                        }
                      },
                    ),
              userId == 0
                  ? SizedBox()
                  : const SizedBox(
                      height: 35,
                    ),
              ProfileIconWidget(
                image: "assets/images/logout.png",
                text: userId == 0
                    ? '${translation(context).log} ${translation(context).inLog} '
                    : translation(context).logout,
                onTap: () async {
                  print("log");

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setInt('userId', 0);
                  userId = 0;
                  messageUser = false;
                  // ignore: use_build_context_synchronously

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => LoginPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    );

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
Widget buildName({required String name, required String email}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        const SizedBox(height: 4),
        Text(
          '${email} $userId',
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );

Widget buildUpgradeButton() => ButtonWidget(
      text: 'Upgrade To PRO',
      onClicked: () {},
    );

Widget buildAbout() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'About',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'user.about',
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
