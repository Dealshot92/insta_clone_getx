import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngdemo17/controllers/home_controller.dart';
import 'my_feed_page.dart';
import 'my_likes_page.dart';
import 'my_profile_page.dart';
import 'my_search_page.dart';
import 'my_upload_page.dart';

class HomePage extends StatefulWidget {
  static final String id = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (context) {
          return PageView(
            controller: _controller.pageController,
            children: [
              MyFeedPage(
                pageController: _controller.pageController,
              ),
              const MySearchPage(),
              MyUploadPage(
                pageController: _controller.pageController,
              ),
              const MyLikesPage(),
              const MyProfilePage(),
            ],
            onPageChanged: (int index) {
              setState(() {
                _controller.currentTap = index;
              });
            },
          );
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (int index) {
          _controller.animateToPage(index);
        },
        currentIndex: _controller.currentTap,
        activeColor: const Color.fromRGBO(193, 53, 132, 1),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
