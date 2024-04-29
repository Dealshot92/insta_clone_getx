import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ngdemo17/pages/signin_page.dart';

import '../model/member_model.dart';
import '../pages/home_page.dart';
import '../services/auth_service.dart';
import '../services/db_service.dart';
import '../services/prefs_service.dart';
import '../services/utils_service.dart';

class SignupController extends GetxController {
  var isLoading = false;
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  doSignUp(context) async {
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();

    if (fullname.isEmpty || email.isEmpty || password.isEmpty) return;

    if (cpassword != password) {
      Utils.fireToast("Password and confirm password does not match");
      return;
    }

    isLoading = true;
    update();

    AuthService.signUpUser(context, fullname, email, password)
        .then((firebaseUser) => {
              getFirebaseUser(firebaseUser, Member(fullname, email)),
            });
  }

  getFirebaseUser(User? firebaseUser, Member member) async {
    isLoading = false;
    update();
    if (firebaseUser != null) {
      //save user id locally
      _saveMemberIdToLocal(firebaseUser);

      //save member to database
      _saveMemberToCloud(member);

      callHomePage(firebaseUser);
    } else {
      Utils.fireToast('Check your information');
    }
  }

  _saveMemberIdToLocal(User firebaseUser) async {
    await Prefs.saveUserId(firebaseUser.uid);
  }

  _saveMemberToCloud(Member member) async {
    await DBService.storeMember(member);
  }

  callHomePage(context) {
    // Navigator.pushReplacementNamed(context, HomePage.id);
    Get.off(HomePage.id, arguments: context);
  }

  callSignInPage(context) {
    // Navigator.pushReplacementNamed(context, SignInPage.id);
    Get.off(SignInPage.id, arguments: context);
  }
}
