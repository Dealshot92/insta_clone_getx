import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ngdemo17/pages/home_page.dart';
import 'package:ngdemo17/pages/signup_page.dart';

import '../services/auth_service.dart';
import '../services/prefs_service.dart';
import '../services/utils_service.dart';

class SigninController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false;

  doSignIn(context) {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if (email.isEmpty || password.isEmpty) return;

    isLoading = true;
    update();

    AuthService.signInUser(context, email, password).then((firebaseUser) => {
          _getFirebaseUser(firebaseUser),
        });
  }

  _getFirebaseUser(User? firebaseUser) async {
    isLoading = false;
    update();

    if (firebaseUser != null) {
      await Prefs.saveUserId(firebaseUser.uid);
      callHomePage(firebaseUser);
    } else {
      Utils.fireToast('Check your email or password');
    }
  }

  callHomePage(context) {
    // Navigator.pushReplacementNamed(context, HomePage.id);
    Get.off(HomePage.id, arguments: context);
  }

  callSignUpPage(context) {
    // Navigator.pushReplacementNamed(context, SignUpPage.id);
    Get.off(SignUpPage.id, arguments: context);
  }
}
