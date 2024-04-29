import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ngdemo17/config/root_binding.dart';
import 'package:ngdemo17/pages/home_page.dart';
import 'package:ngdemo17/pages/my_feed_page.dart';
import 'package:ngdemo17/pages/my_likes_page.dart';
import 'package:ngdemo17/pages/signin_page.dart';
import 'package:ngdemo17/pages/signup_page.dart';
import 'package:ngdemo17/pages/splash_page.dart';
import 'package:ngdemo17/services/notif_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotifService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      initialBinding: RootBinding(),
      routes: {
        SplashPage.id: (context) => const SplashPage(),
        HomePage.id: (context) => const HomePage(),
        SignInPage.id: (context) => const SignInPage(),
        SignUpPage.id: (context) => const SignUpPage(),
      },
    );
  }
}
