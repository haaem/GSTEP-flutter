import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:get/get.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool isLogin = await _googleLogin();
        if (isLogin) {
          Get.toNamed('/profile_setting');
        }
      },
      child: Container(
        height: 40,
        width: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white
        ),
        child: Row(
          children: [
            SizedBox(width: 20,),
            Image.asset('assets/images/googlelogo.png', height: 24, width: 24,),
            SizedBox(width: 30,),
            BodyText(text: 'Sign in with Google', weight: FontWeight.w400,)
          ],
        ),
      ),
    );
  }

  Future<bool> _googleLogin() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication authentication = await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );
    UserCredential? userCredential = await _auth.signInWithCredential(credential);
    var user = userCredential.user;
    if (user != null) {
      log('로그인 성공');
      log('name = ${user.displayName}');
      log('email = ${user.email}');
      log('id = ${user.uid}');
      return Future.value(true);
    }
    return Future.value(false);
  }
}
