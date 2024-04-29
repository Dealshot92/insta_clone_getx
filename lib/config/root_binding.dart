import 'package:get/get.dart';
import 'package:ngdemo17/controllers/home_controller.dart';
import 'package:ngdemo17/controllers/signin_controller.dart';

import '../controllers/my_feed_controller.dart';
import '../controllers/my_likes_controller.dart';
import '../controllers/my_profile_controller.dart';
import '../controllers/my_search_controller.dart';
import '../controllers/my_upload_controller.dart';
import '../controllers/signup_controller.dart';
import '../controllers/splash_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SigninController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => FeedController(), fenix: true);
    Get.lazyPut(() => LikesController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MySearchController(), fenix: true);
    Get.lazyPut(() => UploadController(), fenix: true);
  }
}
