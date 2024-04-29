import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ngdemo17/controllers/splash_controller.dart';
import 'package:ngdemo17/pages/signin_page.dart';
import 'package:ngdemo17/services/auth_service.dart';

import '../services/log_service.dart';
import '../services/notif_service.dart';
import '../services/prefs_service.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'splash_page';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = Get.find<SplashController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.initTimer(context);
    _controller.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (context){
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(193, 53, 132, 1),
                    Color.fromRGBO(131, 58, 180, 1),
                  ]),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Instagram',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Billabong',
                        fontSize: 45,
                      ),
                    ),
                  ),
                ),
                Text(
                  'All rights reserved',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
