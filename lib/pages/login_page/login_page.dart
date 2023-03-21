import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/title_text.dart';
import 'package:twentyone_days/pages/home/main_page.dart';
import 'google_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_setting_page.dart';

enum LoginState {
  login,
  logout,
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.hasData && ProfileSettingPageState.profileSetting) {
              return const MainPage();
            } else if (snapshot.hasData) {
              return const ProfileSettingPage();
            } else {
              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: primaryLightGreen2,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height/2 - 150,
                        ),
                        TitleText(
                          text: 'GSTEP',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          weight: FontWeight.w700,
                        ),
                        SizedBox(height: 30,),
                        GoogleLoginButton()
                      ],
                    ),
                  ),
                ),
              );
            }
          }
      )
    );
  }
}
